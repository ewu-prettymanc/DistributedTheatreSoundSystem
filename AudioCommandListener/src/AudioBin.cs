/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using System.Collections.Generic;
using System.Diagnostics;

/// <summary>
/// Audio bin.
/// <author>
/// Colton Prettyman
/// </author>
/// AudioBin. This class is a provides a Container mechanism for multiple to create and manipulate multiple objects
/// both individually and collectively. Upon exit the user must call the CloseBin method.
/// </summary>
namespace Audio
{
	public class AudioBin
	{
		private Dictionary<String, Audio> _bin = null; // Dictionary for Audio object lookup and storage

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Initializes a new instance of the <see cref="Audio.AudioBin"/> class.
		/// </summary>
		public AudioBin ()
		{
			// Initialize a new empty dictionary
			_bin = new Dictionary< String, Audio> ();

			try {
				// Preinitialize Gstreamer to save time.1
				Gst.Application.Init (); 
			}
			catch( Exception e){
				LogIO.LogException.LogToFile(e, "Error initializing Gstreamer");
			}
		}

		~AudioBin()
		{
			this.CloseBin();
		}

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Adds a new Audio object with the specified metadata to the Audiobin, and starts playing it. 
		/// </summary>
		/// <param name="key"> the unique key representing this audio instance
		/// <param name="fname">Fname.</param>
		/// <param name="fadein">Fadein.</param>
		/// <param name="fadeout">Fadeout.</param>
		/// <param name="delay">Delay.</param>
		/// <param name="volume">Volume.</param>
		/// <param name="position">Position.</param>
		/// <param name="distance">Distance.</param>
		/// <param name="loops"> 0 means play 1 time, -1 means play infinitly</param>
		/// <returns True if the placement data was valid </returns>
		public bool Start( String key=null, String fname=null, int fadein=0, int fadeout=0, int delay=0, double volume=10, double pitch=0, double tempo=0)
		{

			if (_bin.ContainsKey (key))
				return false;

			try{
				Audio a = new Audio (this, key,fname, fadein, fadeout, delay, volume, pitch, tempo);

				// Initialize the Audio
				if (! a.Initialize ())
					return false;

				_bin.Add (key, a);

				// Start playing the sound
				this.Play(key);

				return true;
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}

			return false;
		} // end AddAudio

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Sets the global volume for the whole system. Max input is 100% and min input is 0% inclusive
		/// </summary>
		/// <param name="percent">Percent.</param>
		public void GlobalVolume(double percent )
		{
			try {
				// Scale the input volume to 0-100 dy = (100/100)x
				// logarithmic to linear scaling
				double temp = percent == 0 ? 0 : Math.Log(percent)*22;
			
				ProcessStartInfo psi = new ProcessStartInfo();
				psi.FileName = "amixer";
				// TODO: /sbin/amixer ?
				psi.Arguments = "sset Master " + temp + "%";

				// Attempt setting the Master first, if that doesn't work than set the PCM
				Process p = Process.Start (psi);
				p.WaitForExit ();
				if (p.ExitCode != 0) {
					Console.Out.WriteLine("Trying PCM instead");
					psi.Arguments = "sset PCM " + temp + "%";
					p = Process.Start (psi);
					p.WaitForExit ();
					if( p.ExitCode != 0 )
						throw new Exception ("Error setting global volume using MASTER 0-110%: " + percent + ", -- scaled to 0-100%: " + temp);
				}
			} catch (Exception e ){
				LogIO.LogException.LogToFile(e);
			}
		} // end GlobalVolume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Changes the pitch for the specified key. -10-10. 0 being unchanged
		/// </summary>
		/// <param name="key">Key.</param>
		/// <param name="pitch">Pitch.</param>
		public void Pitch( String key, double pitch )
		{
			try {
				_bin[key].Pitch(pitch); // Close the Audio object
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Pitch

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Pitchs all.
		/// </summary>
		/// <param name="pitch">Pitch.</param>
		public void PitchAll(double pitch)
		{
			try {
				foreach (KeyValuePair<String, Audio> pair in _bin)
					pair.Value.Pitch (pitch);
			} 
			catch (Exception e ){
				LogIO.LogException.LogToFile(e);
			}
		} // end PitchAll

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Changes the tempo for the specified key. -10-10. 0 being unchanged
		/// </summary>
		/// <param name="key">Key.</param>
		/// <param name="tempo">Tempo.</param>
		public void Tempo( String key, double tempo )
		{
			try {
				_bin[key].Tempo(tempo); // Close the Audio object
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Tempo

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Tempos all.
		/// </summary>
		/// <param name="tempo">Tempo.</param>
		public void TempoAll(double tempo)
		{
			try {
				foreach (KeyValuePair<String, Audio> pair in _bin)
					pair.Value.Tempo (tempo);
			} 
			catch (Exception e ){
				LogIO.LogException.LogToFile(e);
			}
		} // end VolumeAll

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Sets the volume for the audio object represented by the key param
		/// </summary>
		/// <param name="key">Key.</param>
		/// <param name="volume">Volume.</param>
		public void Volume( String key, double volume )
		{
			try {
				_bin[key].Volume(volume); // Close the Audio object
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Volume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Sets the volume for all audio objects in the audio bin to the specified volume represented by the param. 0-100% of MAX VOLUME
		/// </summary>
		/// <param name="v">V.</param>
		public void VolumeAll(double percent)
		{
			try {
				foreach (KeyValuePair<String, Audio> pair in _bin)
					pair.Value.Volume (percent);
			} catch (Exception e ) {
				LogIO.LogException.LogToFile(e);
			}
		} // end VolumeAll

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Scales the volume for the specified key by a percentage relative to the current volume.
		/// </summary>
		/// <param name="key">Key.</param>
		/// <param name="percent">Percent.</param>
		public void ScaleVolume(String key, double percent)
		{
			try {
				_bin[key].ScaleVolume(percent); // Close the Audio object
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end ScaleVolume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Scales the global volume relative to the current volume.
		/// </summary>
		/// <param name="percent">Percent.</param>
		public void ScaleAllVolume( double percent )
		{
			try {
				foreach (KeyValuePair<String, Audio> pair in _bin)
					pair.Value.ScaleVolume (percent);
			} 
			catch (Exception e) {
				LogIO.LogException.LogToFile(e);
			}
		} // end ScaleGlobalVolume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Pause the specified key.
		/// </summary>
		/// <param name="key">Key.</param>
		public void Pause(String key )
		{
			try {
				_bin[key].Pause(); // Close the Audio object
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Pause

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Pauses all audio objects in the audio bin.
		/// </summary>
		public void PauseAll()
		{
			try {
				foreach (KeyValuePair<String, Audio> pair in _bin)
					pair.Value.Pause ();
			}
			catch (Exception e) {
				LogIO.LogException.LogToFile(e);
			}
		} // end GlobalPause

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Stop the specified key.
		/// </summary>
		/// <param name="key">Key.</param>
		public void Stop(String key)
		{
			try {
				_bin[key].Stop(); // Close the Audio object
				_bin.Remove(key);
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Stop

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		///  Stops all audio objects in the audio bin.
		/// </summary>
		public void StopAll()
		{
			try{
				CloseBin ();
			} 
			catch (Exception e) {
				LogIO.LogException.LogToFile(e);
			}
		} // end StopAll

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Resume the specified key.
		/// </summary>
		/// <param name="key">Key.</param>
		public void Resume(String key)
		{
			try {
				_bin[key].Resume(); // Close the Audio object
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Resume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Resumes currently paused audio objects. 
		/// </summary>
		public void ResumeAll()
		{
			try {
				foreach (KeyValuePair<String, Audio> pair  in _bin)
					pair.Value.Resume ();
			} 
			catch ( Exception e) {
				LogIO.LogException.LogToFile(e);
			}
		} // end ResumeAll

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Play the specified key.
		/// </summary>
		/// <param name="key">Key.</param>
		public void Play( String key )
		{
			try {
				_bin[key].Play(); // Close the Audio object
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Play

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		///  Plays all audio objects in the audiobin.
		/// </summary>
		public void PlayAll()
		{
			try {
				foreach (KeyValuePair<String, Audio> pair  in _bin)
					pair.Value.Play ();
			}
			catch ( Exception e) {
				LogIO.LogException.LogToFile(e);
			}
		} // end PlayAll

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Attempts to Remove and destroy the specified Audio object represented by the passed in key.
		/// </summary>
		/// <param name="key">Key.</param>
		public void Remove( String key )
		{
			try {
				_bin[key].Close(); // Close the Audio object

				_bin.Remove(key); // Remove it from the list
			}
			catch (KeyNotFoundException k) {
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}
		} // end Remove
			
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Gets the max volume.
		/// </summary>
		/// <returns>The max volume.</returns>
		public double GetMaxVolume()
		{
			return Audio.MAXVOL;
		}// GetMaxVolume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Gets the duration.
		/// </summary>
		/// <returns>The duration.</returns>
		/// <param name="key">Key.</param>
		public double GetDuration( String key )
		{
			double duration = 0;

			try {
				duration = _bin[key].GetDuration();
			}
			catch( KeyNotFoundException k ){
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}

			return duration;
		} // GetDuration

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Gets the position.
		/// </summary>
		/// <returns>The position.</returns>
		/// <param name="key">Key.</param>
		public double GetPosition( String key )
		{
			double position = 0;

			try {
				position = _bin[key].GetPosition();
			}
			catch( KeyNotFoundException k ){
				LogIO.LogException.LogToFile(k, "Invalid key: " + key);
			}

			return position;
		} // GetPosition

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Clears the AudioBin.
		/// </summary>
		public void CloseBin()
		{
			try {
				foreach (KeyValuePair<String, Audio> pair  in _bin)
					pair.Value.Close ();
					
				_bin.Clear ();
			}
			catch (Exception e) {
				LogIO.LogException.LogToFile(e);
			}
		}// end ClearBin
	}
}


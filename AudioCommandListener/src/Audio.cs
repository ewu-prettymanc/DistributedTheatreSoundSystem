/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using GLib;
using System.Threading;
using Gst;
using System.IO;
using System.Timers;

/// <summary>
/// http://stackoverflow.com/questions/7357790/gstreamer-and-music-processing
/// http://blog.scphillips.com/2013/01/getting-gstreamer-to-work-on-a-raspberry-pi/
/// gst-launch filesrc location=sound.mp3 ! decodebin ! audioconvert ! pitch pitch=1.0 tempo=2 ! autoaudiosink
/// use gst-inspect <element> // to find the element details ie. "gst-inspect filesrc"
/// <author>
/// Colton Prettyman
/// </author>
/// Audio. This class allows the user to create audio objects which
/// can play .wav files. This audio object can be played, paused, fadein,
/// fadeout,or delayed.
/// </summery>

namespace Audio
{
	//============================================================================================================
	class Audio 
	{
		#region Audio Members
		public const int DELAYFPS = 20;
		public const double MAXVOL = 10;
		public const double MAXPITCH = 10;
		public const double FADEDV = .001; // The amount to increment or decrement the volume per fade tick.
		enum FadingStatus {FadingIn, FadingOut, NoFading};

		private Pipeline _pipeline; // Pipeline for gstreamer processing
		private Element _source; // Source (file) for gstreamer start point
		private Element _decoder; // Decoder for the input audio files
		private Element _audioconverter; // Converter for the audio stream
		private Element _audioconverter1; // Post converter for the audio stream after filters added
		private Element _audioresampler;
		private Element _gvolume; // Volume processing element gstreamer
		private Element _gpitch; // Pitch processing element gstreamer
		private Element _audiosink; // Sink for audio processing and output to speakers
		private State _state = State.Null; // The current state of the Gstreaming process
		private Caps _caps; // capabilities for autoplugging
		private Pad _audiopad; // pad for autoplugging for decodebin dynamic formats

		private int _fadein;
		private int _fadeout;
		private int _delay;
		private int _delayTicks;
		private double _volume;
		private double _curvolume;
		private double _pitch;
		private double _tempo;
		private int _progressTime; // The current progress time of the Sound file. In seconds.
		private double _songLength; // In milliseconds
		private String _key;
		private String _fname;
		private AudioBin _bin;

		private FadingStatus _fadingStatus=FadingStatus.NoFading;
        private System.Timers.Timer _fadeInTimer = null;
		private System.Timers.Timer _fadeOutTimer = null;
		private System.Timers.Timer _progressTimer = null;
		private System.Timers.Timer _delayTimer = null;
		#endregion

		#region Constructor / Destructor
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Initializes a new instance of the <see cref="Audio.Audio"/> class.
		/// </summary>
		/// <param name="bin">Bin.</param>
		/// <param name="key">Key.</param>
		/// <param name="fname">Fname.</param>
		/// <param name="fadein">Fadein.</param>
		/// <param name="fadeout">Fadeout.</param>
		/// <param name="delay">Delay.</param>
		/// <param name="volume">Volume.</param>
		/// <param name="pitch">Pitch.</param>
		public Audio(AudioBin bin, String key, String fname, int fadein=0, int fadeout=0, int delay=0, double volume=10, double pitch=0, double tempo=0)
		{
			_bin=bin;
			_key = key;
			_fadein = fadein;
			_fadeout = fadeout;
			_delay = delay;
			volume = 100-Math.Log (100-volume) * 22;

			if( volume > 100 )
				volume = 100;
			if( volume < 0 )
				volume = 0;
			_volume = 0.1*volume; // scale between 0-10 from 0-100 scale
			Console.Out.WriteLine (_volume);
			_curvolume = _fadein == 0 ? _volume : 0;

			// pitch: -10--10; _pitch: 0-10: 1=median
			pitch = pitch / 10;
			if (pitch < 0 && pitch >= -1*MAXPITCH)
				_pitch=1-(.9/10.0)*(-1*pitch);
			else if (pitch > 0 && pitch <= MAXPITCH)
				_pitch = 0.9*pitch+1;
			else
				_pitch = 1;

			// tempo: -10--10; _tempo: 0-10: 1=median
			tempo = tempo / 10;
			if (tempo < 0 && tempo >= -1*MAXPITCH)
				_tempo=1-(.9/10.0)*(-1*tempo);
			else if (tempo > 0 && tempo <= MAXPITCH)
				_tempo = 0.9*tempo+1;
			else
				_tempo = 1;

			Console.Out.WriteLine ("tempo is : " + _tempo + " Pitch is : " + _pitch);
			// Prependend the directory to the webapp/
			_fname = fname;
		} // end Audio

		~Audio () { this.Close(); } // end ~Audio

		/// <summary>
		/// Initializes Audio elements which may fail to initialize
		/// </summary>
		public bool Initialize()
		{
			try{
				// Initialize the Gstreamer library...TODO: Call deinit
				//Gst.Application.Init (); 

				if( ! CreatePipeline () ) {
					throw new Exception();
				}

				//Timer related initization.
				_progressTimer = new System.Timers.Timer ();
				_progressTimer.Elapsed += new ElapsedEventHandler (ProgressTimerTick);//Attach the _progressTimer to ProgressTimerTick method.
				_progressTimer.Interval = 1; // Set the progress timer to Tick every msec;

				if (_delay != 0) {
					_delayTimer = new System.Timers.Timer ();
					_delayTimer.Elapsed += new ElapsedEventHandler (DelayTimerTick); // Attach the _delayTimer to the _delayTimerTick method.
					_delayTimer.Interval = DELAYFPS; // 
				}
			} catch ( Exception e ){
				LogIO.LogException.LogToFile(e, "Error initializing Audio: " + this );
				return false;
			}

			return true;
		} // end Initialize

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Creates the gstreamer pipeline.
		/// </summary>
		/// <returns><c>true</c>, if pipeline was created, <c>false</c> otherwise.</returns>
		/// <param name="fname">Fname.</param>
		private bool CreatePipeline()
		{
			// Check for valid files
			if (File.Exists ("../WEBAPP/" + _fname))
				_fname = "../WEBAPP/" + _fname;
			else if (File.Exists ("../webapp/" + _fname))
				_fname = "../webapp/" + _fname;
			else
			{
				LogIO.LogException.LogToFile( "Invalid filename: ");
				return false;
			}
		
			try {
				// Allocate a the pipeline for processing
				_pipeline = new Pipeline ("_pipeline-"+_key);
				if(  _pipeline == null )
					throw new Exception("Error creating pipeline");

				// Allocate the element which reads from the file and outputs data
				_source = ElementFactory.Make ("filesrc", "filesrc-"+_key);
				if(  _source == null )
					throw new Exception("Error creating filesrc element");

				// Allocate the decoder using decodebin to autodetect filetypes
				_decoder = ElementFactory.Make ("decodebin2", "decodebin2-"+_key);
				if(  _decoder == null)
					throw new Exception("Error creating decodebin element");
				_decoder.PadAdded += HandleDecoderPadAdded;

				// Allocate the audio converter for the stream
				_audioconverter = ElementFactory.Make("audioconvert","audioconverter-"+_key);
				if(  _audioconverter == null )
					throw new Exception("Error creating audioconveter element");

				// Allocate the pitch processing element
				_gpitch = ElementFactory.Make ("pitch", "pitch-"+_key);
				if(  _gpitch == null )
					throw new Exception("Error creating pitch element");

				// Allocate the audio converter for the stream
				_audioconverter1 = ElementFactory.Make("audioconvert","audioconverter1-"+_key);
				if(  _audioconverter1 == null )
					throw new Exception("Error creating audioconveter element");
					
				// Allocate the volume processing element
				_gvolume = ElementFactory.Make( "volume", "volume-"+_key);
				if( _gvolume == null)
					throw new Exception("Error creating volume element");

				// Allocate the audio resampler for the stream
				_audioresampler = ElementFactory.Make("audioresample", "audioresample-"+_key);
				if(  _audioconverter1 == null )
					throw new Exception("Error creating audioresample element");
				// Allocate the element which does the audio processing and outputs in this case to the speakers
				_audiosink = ElementFactory.Make ("autoaudiosink", "audiosink-"+_key);
				if( _audiosink == null)
					throw new Exception("Error creating autoaudiosink element");

				// Add the elements to the pipeline
				_pipeline.Add (_source); 
				_pipeline.Add (_decoder);
				_pipeline.Add (_audioconverter);
				_pipeline.Add(_audioconverter1);
				_pipeline.Add (_gpitch);
				_pipeline.Add (_gvolume);
				_pipeline.Add(_audioresampler);
				_pipeline.Add (_audiosink);

				// Set the Element properties
				_source["location"] = _fname;
				_gpitch["pitch"] = (float)_pitch; // Set the pitch for the pitch element....also set ["tempo]=tempval here if desired
				_gpitch["tempo"] = (float)_tempo; // Set the tmepo

				_gvolume["volume"]=_curvolume; // Set the volume
	
				// Link the different elements into the pipleline 
				// :--audio file---source-->--decoder-->--pitch-->--volume-->--audiosink--->soundcard--:
				_source.Link (_decoder);
				_decoder.Link ( _audioconverter);
				_audioconverter.Link(_gpitch);
				_gpitch.Link (_audioconverter1);
				_audioconverter1.Link(_gvolume);
				_gvolume.Link(_audioresampler);
				_audioresampler.Link(_audiosink);
				_state = State.Ready;
				_pipeline.SetState (_state);
				_pipeline.Bus.AddWatch( 1 , new BusFunc( OnBusMessage ) );
			} 
			catch ( Exception e ) {
				LogIO.LogException.LogToFile (e, "Make sure the approprate Gstreamer plugin is installed");
				return false;
			}

			return true;
		} // end CreatePipeline
		#endregion

		#region Audio sound manipulation methods
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Play this Audio instance. Can be called repeatedly safely. This Play method includes 
		/// fading presets.
		/// </summary>
		public void Play()
		{ 				
			try{
				if (_delayTimer != null)
					_delayTimer.Start ();
				else if( _state ==  State.Ready ) {
					_state = State.Playing;
					_pipeline.SetState (_state);
					FadeIn (); // If needed initialize the play timer.
					ResumeTimers ();
				}
			} catch( Exception e ){
				LogIO.LogException.LogToFile (e, "Error playing Audio: " + this);
			}
		} // End Play

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Pause this Audio instance. Can be called repeatedly safely.
		/// </summary>
		public void Pause()
		{
			try{
				if (_delayTimer != null)
					_delayTimer.Stop ();
				else if ( _state == State.Playing ) {
					_state = State.Paused;
					_pipeline.SetState (_state);
					PauseTimers ();
				}
			} catch( Exception e ){
				LogIO.LogException.LogToFile (e, "Error pausing Audio: " + this);
			}
		} // End Pause

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Resume this instance.
		/// </summary>
		public void Resume()
		{
			try{
				if (_delayTimer != null)
					_delayTimer.Start ();
				else if ( _state == State.Paused ) {
					_state = State.Playing;
					_pipeline.SetState (_state);
					ResumeTimers ();
				}
			} catch( Exception e ) {
				LogIO.LogException.LogToFile (e, "Error resuming Audio: " + this);
			}
		} // end Resume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Stop this Audio instance.
		/// </summary>
		public void Stop()
		{
			Close ();
			_state = State.Null;
		} // end Stop

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Sets the pitch. Input -10-10. 0 being unchanged
		/// </summary>
		/// <param name="pitch">Pitch.</param>
		public void Pitch( double pitch)
		{
			try{
				pitch=pitch/10;
				if (pitch < 0 && pitch >= -1*MAXPITCH)
					_pitch=1-(.9/10.0)*(-1*pitch);
				else if (pitch > 0 && pitch <= MAXPITCH)
					_pitch = 0.9*pitch+1;
				else
					_pitch = 1;

				_gpitch["pitch"]=(float)_pitch;
			} catch( Exception e ) {
				LogIO.LogException.LogToFile (e, "Error changing Audio pitch: " + this );
			}
		}// end Volume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Change tempo for the pitch plugin from soundtouch
		/// </summary>
		/// <param name="tempo">Tempo.</param>
		public void Tempo( double tempo)
		{
			try{
				tempo=tempo/10;
				if (tempo < 0 && tempo >= -1*MAXPITCH)
					_tempo=1-(.9/10.0)*(-1*tempo);
				else if (tempo > 0 && tempo <= MAXPITCH)
					_tempo = 0.9*tempo+1;
				else
					_tempo = 1;

				_gpitch["tempo"]=(float)_tempo;

				// Update the song length if the tempo changed
				Format f = Format.Time;
				long length;
				_pipeline.QueryDuration( ref f, out length);
				_songLength = length/1000000.0; // convert from nano seconds to mseconds
				Console.Out.WriteLine(_key+"----Updated Duration: " + _songLength/1000 );

			} catch( Exception e ) {
				LogIO.LogException.LogToFile (e, "Error changing Audio tempo: " + this );
			}
		}// end Volume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Sets the volume for the current Audio instance. Can be called while an audio instance is playing. Generally global volume adjustemsnt
		/// will not be done by this method.
		/// </summary>
		/// <param name="v"> The desired volume of the Audio instance</param>
		public void Volume( double percent)
		{
			try{
				percent = 100-Math.Log (100-percent) * 22;
				if( percent > 100 )
					percent = 100;
				if( percent < 0 )
					percent = 0;
				_curvolume = (percent/100.0)*MAXVOL;
				_gvolume["volume"]=_curvolume;
			} catch( Exception e ) {
				LogIO.LogException.LogToFile (e, "Error changing Audio volume: " + this );
			}
		}// end Volume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Scales the current volume as a percentage relative to the Audio objects initiated volume. For global volume adjustments use this method!
		/// </summary>
		/// <param name="v"> The desired volume of the Audio instance</param>
		public void ScaleVolume( double percent)
		{
			try{
				percent = Math.Log (percent) * 22;
				if( percent < 0 )
					percent = 0;
				_curvolume =  (percent/100.0)*_curvolume;
				if (_curvolume > MAXVOL)
					_curvolume = MAXVOL;

				_gvolume ["volume"] = _curvolume;
			} catch( Exception e ){
				LogIO.LogException.LogToFile (e, "Error scaling Audio volume: " + this );
			}
		}// end Volume

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Fades the sound in
		/// </summary>
		private void FadeIn()
		{
			try{
				if (_fadein == 0 || _volume == 0 )
					return;

				if (_fadeInTimer == null && _fadingStatus == FadingStatus.NoFading ) {
					double dt = (FADEDV * _fadein) / _volume; // DV = (volume/time)*DT, but DT is constant at 1
					if( dt < 1 )
						dt = 1;

					_curvolume = 0;

					_fadeInTimer = new System.Timers.Timer ();
					_fadeInTimer.Elapsed += new ElapsedEventHandler (FadeInTimerTick); // Attach the fade in timer to the fade in timer.
					_fadeInTimer.Interval = dt;
					_fadingStatus = FadingStatus.FadingIn;
					_fadeInTimer.Start ();
				}
			} catch(Exception e) {
				LogIO.LogException.LogToFile (e, "Error fading in Audio: " + this );
			}
		}// end FadeIn

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Fades the sound out
		/// </summary>
		private void FadeOut()
		{
			try{
				if (_fadeout == 0 || _volume == 0 )
					return;

				if (_fadeOutTimer == null && _fadingStatus == FadingStatus.NoFading ) {
					double dt = (FADEDV * _fadeout) / _volume; // DV = (volume/time)*DT, but DT is constant at 1
					if( dt < 1 )
						dt = 1;

					_fadeOutTimer = new System.Timers.Timer ();
					_fadeOutTimer.Elapsed += new ElapsedEventHandler (FadeOutTimerTick); // Attach the fade in timer to the fade in timer.
					_fadeOutTimer.Interval = dt;
					_fadingStatus = FadingStatus.FadingOut;
					_fadeOutTimer.Start ();
				}
			} catch(Exception e ){
				LogIO.LogException.LogToFile (e, "Error fading out Audio: " + this );
			}
		} // end FadeOut

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Pauses the fading and progress timers
		/// </summary>
		private void PauseTimers()
		{
			try{
				switch (_fadingStatus) {
				case FadingStatus.FadingIn:
					_fadeInTimer.Stop ();
					break;
				case FadingStatus.FadingOut:
					_fadeOutTimer.Stop ();
					break;
				}

				_progressTimer.Stop ();
			} catch(Exception e ){
				LogIO.LogException.LogToFile (e, "Error pausing Audio timers: " + this );
			}
		} // end PauseFading

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Resumes the fading and progress timers
		/// </summary>
		private void ResumeTimers()
		{
			try{
				switch (_fadingStatus) {
				case FadingStatus.FadingIn:
					_fadeInTimer.Start ();
					break;
				case FadingStatus.FadingOut:
					_fadeOutTimer.Start ();
					break;
				}

				_progressTimer.Start ();
			} catch(Exception e ){
				LogIO.LogException.LogToFile (e, "Error resuming Audio timers: " + this );
			}
		} // end ResumeFading
			
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Close this Audio instance. 
		/// NOTE: When all Audio objects are closed the user should call Mixer.CancelReserveChannels(); 
		/// To restore the sound channels to the system.
		/// </summary>
		public void Close()
		{
			try{
				if (_delayTimer != null)
					_delayTimer.Dispose ();

				if (_fadeInTimer != null)
					_fadeInTimer.Dispose ();

				if (_fadeOutTimer != null) 
					_fadeOutTimer.Dispose ();
				
				if (_progressTimer != null) 
					_progressTimer.Dispose ();

				_pipeline.SetState (State.Null);
				//_pipeline.Dispose();
				//Gst.Application.Deinit ();
			} catch( Exception e ){
				LogIO.LogException.LogToFile (e, "Error closing Audio: " + this );
			}
		} // end Close
		#endregion

		#region Event handlers
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Handles the decodebin pad added event.
		/// </summary>
		/// <param name="o">O.</param>
		/// <param name="args">Arguments.</param>
		void HandleDecoderPadAdded (object o, PadAddedArgs args)
		{
			try {
				Structure str;
				_audiopad = _audioconverter.GetStaticPad ("sink");

				if (_audiopad.IsLinked) 
					return;

				_caps = args.Pad.Caps;
				_caps.Owned = true;
				str = _caps[0];
				str.Owned= true;
				if( ! str.Name.Contains("audio"))
					return;
				
				args.Pad.Link(_audiopad);
			} catch( Exception e ){
				LogIO.LogException.LogToFile (e, "Error handling Audio decoder pad added: " + this );
			}
		} // end LoadFile

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Handles Bus messages
		/// </summary>
		/// <param name="bus">Bus.</param>
		/// <param name="message">Message.</param>
		private bool OnBusMessage( Bus bus, Message message) 
		{
			try {
				switch( message.Type ) {
				case MessageType.Error: // error in the stream
					String err = "";
					Enum e;
					message.ParseError ( out e, out err);
					LogIO.LogException.LogToFile ("Gstreamer error: " + err +"\n" + e.ToString() );
					break;
				case MessageType.Eos: // End of stream
					_bin.Remove (_key); // Remove me from the parent bin.
					Close ();
					break;
				case MessageType.Duration: 
					Format f = Format.Time;
					long length;
					_pipeline.QueryDuration (ref f, out length);
					_songLength = length / 1000000.0; // convert from nano seconds to seconds
					break;
				}
			} catch( Exception e ) {
				LogIO.LogException.LogToFile (e, "Error handling Audio bus message: " + this );
				return false;
			}

			return true;
		} // end BusCB

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Delays the timer tick.
		/// </summary>
		/// <param name="source">Source.</param>
		/// <param name="e">E.</param>
		private void DelayTimerTick( System.Object source, ElapsedEventArgs e )
		{
			try{
				_delayTicks += DELAYFPS;

				if ( _delayTicks >= _delay ) {
					// The delay is over dispose the timer
					_delayTimer.Dispose (); 
					_delayTimer = null;

					// Start the song now.
					Play ();
				}
			}catch(Exception exc ){
				LogIO.LogException.LogToFile (exc, "Error Audio handling delay timer tick: " + this );
			}
		} // end DelayTimerTick

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Handlers the progress timer ticks.
		/// </summary>
		private void ProgressTimerTick( System.Object source, ElapsedEventArgs e)
		{
			try{ 
				if (_songLength == 0 ) {
					Format f = Format.Time;
					long length;
					_pipeline.QueryDuration( ref f, out length);
					_songLength = length/1000000.0; // convert from nano seconds to mseconds
					if( _songLength != 0 )
						Console.Out.WriteLine(_key+"----Duration: " + _songLength/1000 );
				}
				_progressTime += 1; // increment the milliseconds for the current tick.
				if (_progressTime % 1000 == 0) {
					string status="";
					if( _delayTimer != null )
						status="Delaying";
					else if(_fadeInTimer != null )
						status="Fading In";
					else if (_fadeOutTimer != null )
						status="Fading Out";

					Console.WriteLine (_key + "----Position: " + _progressTime/1000 + "\tVolume: " + _curvolume + "\tPitch: " + _pitch + "\t" + status);
				}
				// When the current progress time is equal to the time to start fading out than start fading out linearly
				if (  GetPosition() + _fadeout >= _songLength && _fadingStatus == FadingStatus.NoFading && _songLength != 0 )
					FadeOut ();

				// If query for duration fails after 3 seconds of trying remove the song. No orphans!
				if ( (_songLength != 0 && _progressTime > _songLength+20) || 
					( _songLength == 0 && (_progressTime/1000) >= 2 )){
					_bin.Remove (_key); // Remove me from the parent bin.
					Close ();
				}
			} catch ( Exception exc ){
				LogIO.LogException.LogToFile (exc, "Error Audio handling progress timer tick: " + this );
			}
		} // end TimerTickFadeOut

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Handles the fade int timer tick
		/// </summary>
		/// <param name="Source">Source.</param>
		/// <param name="e">E.</param>
		private void FadeInTimerTick(System.Object Source, ElapsedEventArgs e )
		{
			try {
				// Only perform fading operations one at a time!
				if (_fadingStatus == FadingStatus.FadingIn) {
					if (_curvolume == _volume) {
						_fadeInTimer.Dispose ();
						_fadeInTimer = null;
						_fadingStatus = FadingStatus.NoFading;
						return;
					}

					//Console.Out.WriteLine ("Fading in: " + _curvolume);

					_curvolume += FADEDV; // increment the volume

					if (_curvolume > _volume)
						_curvolume = _volume;

					_gvolume["volume"] = _curvolume; // Set the element volume's property to the new value
				}
			} catch ( Exception exc ) {
				LogIO.LogException.LogToFile (exc, "Error Audio handling fade in timer tick: " + this );
			}
		} // end FadeInTimerTick

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Handles the fade out timer tick
		/// </summary>
		/// <param name="source">Source.</param>
		/// <param name="e">E.</param>
		private void FadeOutTimerTick(System.Object source, ElapsedEventArgs e )
		{
			try{
				// Only perform fading operations one at a time!
				if (_fadingStatus == FadingStatus.FadingOut) {
					if (_volume == 0) {
						_fadeOutTimer.Dispose ();
						_fadeOutTimer = null;
						_fadingStatus = FadingStatus.NoFading;
						return;
					}

					//Console.Out.WriteLine ("Fading out: " + _curvolume);

					_curvolume -= FADEDV; // decrement the current volume

					if (_curvolume < 0)
						_curvolume = 0;
					_gvolume ["volume"] = _curvolume; // Set the element volume's property to the new value
				}
			} catch (Exception exc) {
				LogIO.LogException.LogToFile (exc, "Error Audio handling fade out timer tick: " + this );
			}
		} // end FadeOutTimerTick
		#endregion end event handlers

		#region Get/Set
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Gets the Audio instance duration. Note: This method blocks until a valid duration is retrieved
		/// </summary>
		/// <returns>The duration.</returns>
		public double GetDuration()
		{
			int counter = 0;

			try{
				// Spinlock on _songLength, timeout after 2 seconds
				while (_songLength == 0 && counter < 20 ) {
					System.Threading.Thread.Sleep (100);
					counter++;
				}
			} catch( Exception e ) {
				LogIO.LogException.LogToFile (e, "Error getting duration: " + this );
			}

			return _songLength;
		} // end GetDuration

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Gets the position of the playing audio.
		/// </summary>
		/// <returns>The position.</returns>
		public double GetPosition()
		{
			double position = 0;
			try{
				Format f = Format.Time;
				long pos;
				_pipeline.QueryPosition( ref f, out pos);
				position = pos/1000000.0; // convert from nano seconds to seconds
			} catch( Exception e ){
				LogIO.LogException.LogToFile (e, "Error getting position: " + this );
			}

			return position;
		} // end GetPosition

		#endregion Get/Set

		#region Class Specific Methods
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Returns a <see cref="System.String"/> that represents the current <see cref="Audio.Audio"/>.
		/// </summary>
		/// <returns>A <see cref="System.String"/> that represents the current <see cref="Audio.Audio"/>.</returns>
		public override String ToString()
		{
			String s = "\n [";
			s += " key=" + _key;
			s += ", filename=" + _fname;
			s += ", delay=" + _delay;
			s += ", fadein=" + _fadein;
			s += ", fadeout=" + _fadeout;
			s += ", pitch=" + _pitch;
			s += ", volume=" + _volume;
			s += ", progresstime=" + _progressTime;
			s += ", playingstate=" + _state;
			s += " ]";

			return s;
		}
		#endregion
	} // end Audio class
}
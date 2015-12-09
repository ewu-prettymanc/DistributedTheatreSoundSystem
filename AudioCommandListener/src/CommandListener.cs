/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using System.Threading;
using System.Collections.Generic;
using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Net.NetworkInformation;

namespace Audio
{
	public class CommandListener
	{
		protected AudioBin _bin = null;

		//----------------------------------------------------------------------------------------------------------
		public CommandListener()
		{
			_bin = new AudioBin();
		} // end CommandListern

		//----------------------------------------------------------------------------------------------------------
		public void Run()
		{
			UdpClient sock = new UdpClient (15002);
			IPEndPoint sender = new IPEndPoint (IPAddress.Any, 0); 
			sock.EnableBroadcast = true;
		
			byte[] data = new byte[1024];
			string strdata;

			while (true) {
				try{
					data = sock.Receive (ref sender);
					strdata = Encoding.ASCII.GetString (data);

					Console.WriteLine ("The Command is: " + strdata);
				
					String[] cmdData = strdata.Split (',');

					switch (cmdData[0]) {
						case "START":
							// [START, key, fname, fadein, fadeout, delay, volume, pitch, (later...tempo(someday?) )]
							_bin.Start (cmdData [1], cmdData [2], Convert.ToInt32 (cmdData [3]), Convert.ToInt32 (cmdData [4]), 
							Convert.ToInt32 (cmdData [5]), Convert.ToDouble (cmdData [6]), Convert.ToDouble (cmdData [7]));
							break;
						case "STOP":
							// [STOP, key]
							_bin.Stop (cmdData [1]);
							break;
						case "STOPALL":
							 // [STOPALL]
							_bin.StopAll ();
							break;
						case "PAUSE":
							// [PAUSE, key ]
							_bin.Pause (cmdData [1]);
							break;
						case "PAUSEALL":
							// [PAUSE]
							_bin.PauseAll ();
							break;
						case "RESUME":
							// RESUME, key ]
							_bin.Resume (cmdData [1]);
							break;
						case "RESUMEALL":
							// [RESUMEALL]
							_bin.ResumeAll ();
							break;
						case "SCALEVOLUME":
							// [SCALEVOLUME, percent]
							_bin.ScaleVolume (cmdData [1], Convert.ToDouble (cmdData [2]));
							break;
						case "SCALEALLVOLUME":
							// [SCALEALLVOLUME, percent]
							_bin.ScaleAllVolume (Convert.ToDouble(cmdData[1]));
							break;
						case "GLOBALVOLUME":
							// [GLOBALVOLUME, percent]
							_bin.GlobalVolume (Convert.ToDouble(cmdData[1]));
							break;
						case "PITCH":
						 	// [PITCH, pitch]
							_bin.Pitch(cmdData[1], Convert.ToDouble(cmdData[2]));
							break;
						case "PITCHALL":
							// [PITCHAll]
							_bin.PitchAll(Convert.ToDouble(cmdData[1]));
							break;
						case "TEMPO":
							// [TEMPO, tempo]
							_bin.Tempo(cmdData[1], Convert.ToDouble(cmdData[2]));
							break;
						case "TEMPOALL":
							// [TEMPOALL, tempo]
							_bin.TempoAll(Convert.ToDouble(cmdData[1]));
							break;
						case "VOLUME":
							// [VOLUME, percent]
							_bin.Volume (cmdData [1], Convert.ToDouble(cmdData [2]));
							break;
						case "VOLUMEALL":
							_bin.VolumeAll (Convert.ToDouble(cmdData[1]));
							break;
						case "PLAY":
							// [PLAY, key ]
							_bin.Play (cmdData [1]);
							break;
						case "PLAYALL":
							// [PLAYALL ]
							_bin.PlayAll ();
							break;
						case "REMOVE":
							// [REMOVE, key ]
							_bin.Remove (cmdData [1]);
							break;
						case "GETTIMEINFO":
							// [GETTIMEINFO, key]
							DurationResponder d = new DurationResponder(_bin, cmdData[1], sender.Address.ToString() );
							Thread t = new Thread(new ThreadStart(d.Run));
							t.Start();
							break;
						default :
							LogIO.LogException.LogToFile("Invalid command received: " + strdata);
							break;
					}// end swtich
				} catch( Exception e ) {
					LogIO.LogException.LogToFile(e);
				}
			}// end Run
		}
	}
}

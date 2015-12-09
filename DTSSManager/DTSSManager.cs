/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using System.Diagnostics;
using System.IO;
using System.Threading;
using Mono.Posix;
using Mono.Unix;

namespace DTSSManager
{
	/// <summary>
	/// Runs the audiocommandlistener and webapp forever. Catching errors and restarting as needed.
	/// </summary>
	class DTSSManager
	{
		private static Thread _audiothread = null;
		private static Thread _broadcastthread = null;
		private static Thread _webappthread = null;
		private static Process _audioprocess = null;
		private static Process _broadcastprocess = null;
		private static Process _webappprocess = null;

		/// <summary>
		/// The entry point of the program, where the program control starts and ends.
		/// </summary>
		/// <param name="args">The command-line arguments.</param>
		public static void Main (string[] args)
		{
			// Catch SIGINT and SIGUSR1
			UnixSignal[] signals = new UnixSignal [] {
				new UnixSignal (Mono.Unix.Native.Signum.SIGINT),
				new UnixSignal (Mono.Unix.Native.Signum.SIGUSR1),
				new UnixSignal (Mono.Unix.Native.Signum.SIGHUP),
				new UnixSignal (Mono.Unix.Native.Signum.SIGQUIT),
			};

			Thread signal_thread = new Thread (delegate () {
					// Wait for a signal to be delivered
					int index = UnixSignal.WaitAny (signals, -1);
					Mono.Unix.Native.Signum signal = signals [index].Signum;

					KillProcess();
			});

			signal_thread.Start ();

			Console.CancelKeyPress += new ConsoleCancelEventHandler(HandleConsoleCancelEventHandler);
			Console.Out.WriteLine ("Starting audiocommandlistener thread...");
			_audiothread = new Thread (RunAudioCommandListener);
			_audiothread.Start ();

			Console.Out.WriteLine ("Starting broadcastlistener thread...");
			_broadcastthread = new Thread (RunBroadcastListener);
			_broadcastthread.Start ();

			Console.Out.WriteLine ("Starting webapp thread...");
			_webappthread= new Thread (RunWebApp);
			_webappthread.Start ();

			_audiothread.Join ();
			_broadcastthread.Join ();
			_webappthread.Join ();

			Console.Out.WriteLine ("dtssmanger force exited or crashed");
			Thread.Sleep (5000);
		} // end main

		/// <summary>
		/// Handles the console cancel event handler.
		/// </summary>
		/// <param name="sender">Sender.</param>
		/// <param name="e">E.</param>
		static void HandleConsoleCancelEventHandler (object sender, ConsoleCancelEventArgs e)
		{
			KillProcess ();
		} // end HandleConsoleCancelEventHandler

		/// <summary>
		/// Kills the processes.
		/// </summary>
		static void KillProcess()
		{
			try{
				Console.Out.WriteLine ("dtssmanger caught force kill attempt");

			/*	if (_audiothread != null && _audioprocess != null) {
					Console.Out.WriteLine ("dtssmanager safely closing audiocommandlistener");
					if( _audiothread.IsAlive == true )
						_audiothread.Abort ();
					if( _audioprocess.HasExited == false )
						_audioprocess.Close ();
				}

				if (_broadcastthread!= null && _broadcastprocess!= null) {
					Console.Out.WriteLine ("dtssmanager safely closing broadcastlistener ");
					if( _broadcastthread.IsAlive == true )
						_broadcastthread.Abort ();
					if( _broadcastprocess.HasExited == false)
						_broadcastprocess.Close ();
				}
			*/
				Console.Out.WriteLine ("dtssmanger safely closing webapp");
				if (!File.Exists ("/usr/local/bin/webapp")) {
					Console.Out.WriteLine ("webapp not found");
					return;
				}

				ProcessStartInfo psi = new ProcessStartInfo ();
				psi.FileName = "/usr/local/bin/webapp";
				psi.Arguments = "stop";

				Process p = Process.Start (psi);
				p.WaitForExit ();

				if (_webappthread != null && _webappprocess != null) {
					// Kill the webapp using the webapp stop script to grep off the PID and kill it
					//if (_webappthread.IsAlive == true )
					//	_webappthread.Abort ();

					if ( _webappprocess.HasExited == false) 
						_webappprocess.Close ();
				}

				Console.Out.WriteLine ("Exiting dtssmanager");
				System.Environment.Exit (1);
			} catch (Exception ex ){
				Console.Out.WriteLine(ex);
			}

		} // end Kill process
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Runs the audio command listener.
		/// </summary>
		public static void RunAudioCommandListener()
		{
			if (!File.Exists ("/usr/local/bin/audiocommandlistener")) {
				Console.Out.WriteLine ("audiocommandlistener not found");
				return;
			}

			for( int i=0; i < 10; i++ )  {
				Console.Out.WriteLine ("Starting audiocommandlistener...");
				try {
					ProcessStartInfo psi = new ProcessStartInfo ();
					psi.FileName = "/usr/local/bin/audiocommandlistener";
					psi.Arguments = "start";

					_audioprocess = Process.Start (psi);
					_audioprocess.WaitForExit ();

					if (_audioprocess.ExitCode != 0)
						Console.Out.WriteLine ("audiocommandlistener error.");
				} catch (Exception e) {
					Console.Out.WriteLine (e);
				}
				Thread.Sleep (5000);
			}
		} // end RunAudioCommandListener

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Runs the audio command listener.
		/// </summary>
		public static void RunBroadcastListener()
		{
			if (!File.Exists ("/usr/local/bin/broadcastlistener")) {
				Console.Out.WriteLine ("broadcastlistener not found");
				return;
			}

			for( int i=0; i < 10; i++ )  {
				Console.Out.WriteLine ("Starting broadcastlistener...");
				try {
					ProcessStartInfo psi = new ProcessStartInfo ();
					psi.FileName = "/usr/local/bin/broadcastlistener";
					psi.Arguments = "start";

					_broadcastprocess = Process.Start (psi);
					_broadcastprocess.WaitForExit ();

					if (_broadcastprocess.ExitCode != 0)
						Console.Out.WriteLine ("broadcastlistener error.");
				} catch (Exception e) {
					Console.Out.WriteLine (e);
				}
				Thread.Sleep (5000);
			}
		} // end RunAudioCommandListener

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Runs the web app.
		/// </summary>
		public static void RunWebApp()
		{
			if (!File.Exists ("/usr/local/bin/webapp")) {
				Console.Out.WriteLine ("webapp not found");
				return;
			}

			for(int i=0; i < 1; i++) {
				Console.Out.WriteLine ("Starting webapp...");
				try {
					ProcessStartInfo psi = new ProcessStartInfo ();
					psi.FileName = "/usr/local/bin/webapp";
					psi.Arguments = "start";

					_webappprocess = Process.Start (psi);
					_webappprocess.WaitForExit ();

					if (_webappprocess.ExitCode != 0)
						Console.Out.WriteLine ("webapp error.");
				} catch (Exception e) {
					Console.Out.WriteLine (e);
				}
				Thread.Sleep (5000);
			}
		} // end RunWebap
	}
}
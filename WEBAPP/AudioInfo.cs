/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using System.Diagnostics;

/// <summary>
/// Audio info. To use this file add: using AudioInfo and call GetLength with a path
/// </summary>
namespace Network
{
	public static class AudioInfo
	{
		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Gets the length of the audio file specified by path.
		/// Return of 0 means error or bad file.
		/// Pathnames should in the following format.
		/// /productions/Lord\ of\ the\ Tacos/sounds/chewie.wav
		/// local defaults to true. If not local this means the directory exists from root.
		/// If local is true it will look here and directories lower.
		/// </summary>
		/// <returns>The length.</returns>
		/// <param name="path">Path.</param>
		public static double GetLength ( string path)
		{
			double length=0;

			// Sox is the program which will calculate the audio file length
			try {

				ProcessStartInfo psi = new ProcessStartInfo();
				psi.FileName = "soxi";
				// ./path/to/file -- if local

				psi.Arguments = "-D "+"\'"+path+"\'";

				psi.UseShellExecute = false;
				// Pipe the stdout of soxi -D filename.* back to stdin
				psi.RedirectStandardOutput = true;
				Process p = Process.Start (psi);

				// Grab the output from the process
				string output = p.StandardOutput.ReadToEnd();
				p.WaitForExit ();

				if (p.ExitCode != 0 || output == "" )
					length=0;
				else
					length = Math.Round(Convert.ToDouble(output), 2);

			} catch (Exception e ){
				Console.Error.WriteLine (e + " In AudioInfo/GetLength");
			}

			return length;
		}

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// The entry point of the program, where the program control starts and ends.
		/// This program gets Audio file related info using the program sox. sox must be installed
		/// For this program to execute correctly
		/// </summary>
		/// <param name="args">The command-line arguments.</param>
		public static void Main( string[] args )
		{
			if (args.Length != 1) {
				Console.Out.WriteLine ("Usage: mono AudioInfo.exe /path/to/file");
				Console.Out.WriteLine ("Currently this file looks only from this location to lower directories");
				Environment.Exit(1);
			}

			Console.Out.WriteLine (GetLength (args [0]));
		}
	}
}


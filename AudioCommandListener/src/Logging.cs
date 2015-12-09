/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using System.IO;

namespace LogIO
{
	/// <summary>
	/// Exception Logging
	/// </summary>
	public static class LogException
	{
		public const String LOGFILE = "Audio.log";
		public const bool VERBOSE = true;
		public const bool LOGGING = false;

		/// <summary>
		/// Logs to file.
		/// </summary>
		/// <param name="e">E.</param>
		/// <param name="s">S.</param>
		public static void LogToFile( Object e , String s = "")
		{
			try {
				// Only log errors if we want erros to be dumped to an error log file
				if (LOGGING) {
					TextWriter tw = new StreamWriter (LOGFILE, true);
					tw.WriteLine (e);

					if (s != "") {
						tw.WriteLine (s);
						Console.Error.WriteLine (s);
					}

					tw.WriteLine ();
					tw.Close ();
				}

				if (VERBOSE)
					Console.Error.WriteLine (e);
			} catch( Exception x ) {
				Console.Error.WriteLine(x);
			}
		}// logs the exception.
	}
}


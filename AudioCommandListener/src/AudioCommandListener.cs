/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using System.Threading;

namespace Audio
{
	public class AudioCommandListener
	{
		public static void Main(String[] args )
		{
			while (true) {
				try {
					CommandListener cl = new CommandListener ();

					Console.Out.WriteLine("---Starting AudioCommandListener---");
					cl.Run ();
				} catch( Exception e ) {
					Console.Out.WriteLine ("---AudioCommandListener Exception --- Restarting");
					LogIO.LogException.LogToFile (e);
				}
			}
		}
	}
}

/********************************
 * Colton Prettyman			    *
 * Fall 2014 - Winter 2015      *
 * Senior Project EWU			*
 * Team 6						*
 *******************************/

using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace Audio
{
	/// <summary>
	/// Duration responder.
	/// </summary>
	public class DurationResponder
	{
		protected AudioBin _bin = null;
		protected string _ip="";
		protected string _key = "";
		//----------------------------------------------------------------------------------------------------------
		public DurationResponder ( AudioBin bin, string key, string ip )
		{
			_bin = bin;
			_ip = ip;
			_key = key;
		}

		//----------------------------------------------------------------------------------------------------------
		/// <summary>
		/// Run this instance. May block for at most 2 seconds.
		/// </summary>
		public void Run()
		{
			UdpClient sock = new UdpClient ();
			IPEndPoint iep = new IPEndPoint (IPAddress.Parse (_ip), 15003);
			byte[] data = null;

			// This may block for at most 2 seconds
			double duration = _bin.GetDuration (_key);
			double position = _bin.GetPosition (_key);
			data = Encoding.ASCII.GetBytes ("TIMEINFOREPLY," + _key + "," + duration + "," + position);
			Console.Out.WriteLine ("Sending reply: "+ Encoding.ASCII.GetString (data) );
			sock.Send (data, data.Length, iep);
			sock.Close ();
			Thread.CurrentThread.Abort ();
		}
	}
}


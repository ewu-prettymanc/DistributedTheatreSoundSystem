using System;
using System.Net;
using System.Net.Sockets;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Diagnostics;

namespace Broadcaster
{
	public class Broadcaster
	{
		private int TIME_SECONDS = 3;
		private List<string>address_data; 
		public Broadcaster ()
		{
			this.address_data = new List<string> ();
		}

		public Node[] refresh() 
		{
			this.address_data.Clear ();

			UdpClient sock = new UdpClient ();
			IPEndPoint iep = new IPEndPoint (IPAddress.Broadcast, 15001);

			byte[] data = Encoding.ASCII.GetBytes("PING");

			sock.Send (data, data.Length, iep);

			Stopwatch s = new Stopwatch ();
			s.Start ();
			while (s.Elapsed < TimeSpan.FromSeconds (TIME_SECONDS) || sock.Available != 0) {
				if (sock.Available != 0) {
					byte[] recieve = sock.Receive (ref iep);
					string recieve_string = Encoding.ASCII.GetString (recieve);
					this.address_data.Add (recieve_string);
				}
			}
			string[] raw_data = this.address_data.Distinct ().ToArray ();
			Node[] return_data = new Node[raw_data.Length];

			for (int i = 0; i < return_data.Length; i++)
				return_data[i] = new Node(raw_data[i]);
			return return_data;
		}
	}
}


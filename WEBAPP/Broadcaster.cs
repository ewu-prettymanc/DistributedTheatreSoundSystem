using System;
using System.Threading;
using System.Net;
using System.Net.Sockets;
using System.Collections.Generic;
using System.Text;
using System.Linq;
using System.Diagnostics;

namespace Network
{
	public class Broadcaster
	{
		private readonly object ara_lock = new object ();
		private int TIME_SECONDS = 3;
		private Node[] address_data;
		private Thread t;

		public Broadcaster ()
		{
			this.address_data = new Node[0];
			this.t = new Thread (new ThreadStart(this.run));
			this.t.Start ();

		}

		private void run ()
		{

			while (true && Thread.CurrentThread.IsAlive) {
				UdpClient sock = new UdpClient ();
				IPEndPoint iep = new IPEndPoint (IPAddress.Broadcast, 15001);
				sock.EnableBroadcast = true;

				List<string> address_data_temp = new List<string> ();
				byte[] data = Encoding.ASCII.GetBytes ("PING");
				sock.Send (data, data.Length, iep);

				Stopwatch s = new Stopwatch ();
				s.Start ();
				while (s.Elapsed < TimeSpan.FromSeconds (TIME_SECONDS) || sock.Available != 0) {
					if (sock.Available != 0) {
						byte[] recieve = sock.Receive (ref iep);
						string recieve_string = Encoding.ASCII.GetString (recieve);
						address_data_temp.Add (recieve_string);
					}
				}

				string[] raw_data = address_data_temp.Distinct ().ToArray ();
				lock (ara_lock) {
					Array.Clear(this.address_data,0,this.address_data.Length);
					this.address_data = new Node[raw_data.Length];

					for (int i = 0; i < this.address_data.Length; i++)
						this.address_data [i] = new Node (raw_data [i]);
				}
				sock.Close ();
				try{
					Thread.Sleep (5000);
				}catch(ThreadInterruptedException e) {
					return;
				}
			}
			return;
		}

		public Node[] refresh ()
		{
			if (!this.t.IsAlive)
				return new Node[0];
			lock (ara_lock) {
				return this.address_data;
			}
		}

		public void killThread() {
			if (this.t.IsAlive) {
				this.t.Interrupt ();
				this.t.Join ();
			}
			return;
		}
	}
}


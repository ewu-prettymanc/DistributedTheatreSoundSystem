using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace CommandTester
{
	public class DurationListener
	{
		public DurationListener(){
		}
		public void Run()
		{
			UdpClient sock = new UdpClient (15003);
			IPEndPoint sender = new IPEndPoint (IPAddress.Any, 0); 
			sock.EnableBroadcast = true;

			byte[] data = new byte[1024];
			string strdata;
			bool done = false;

			while (!done) {
				data = sock.Receive (ref sender);
				strdata = Encoding.ASCII.GetString (data);
				String[] cmdData = strdata.Split (',');

				if (cmdData [0] == "TIMEINFOREPLY") {
					done = true;
					Console.Out.WriteLine ("Time Info Reply Packet---[" + strdata + "]");
					Console.Out.Flush ();
				}
			}
			sock.Close ();
			Thread.CurrentThread.Abort ();
		}
	}
}


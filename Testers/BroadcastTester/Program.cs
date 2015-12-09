using System;
using System.Net.Sockets;
using System.Text;
using System.Net;

namespace Broadcaster
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			Broadcaster broadcaster = new Broadcaster ();
			Node[] mac_addresses = broadcaster.refresh ();
			foreach (Node s in mac_addresses) {
				Console.WriteLine (s.toString());
				Console.WriteLine ();
			}

			Console.Write ("index of node to change hostname:");
			int hostname = int.Parse(Console.ReadLine ());
			Console.Write ("index of node to reboot:");
			int reboot = int.Parse(Console.ReadLine ());
			if (hostname >= 0 && hostname < mac_addresses.Length) {
				UdpClient sock = new UdpClient ();
				IPEndPoint iep = new IPEndPoint (IPAddress.Parse(mac_addresses[hostname].ip_address), 15001);

				byte[] data = Encoding.ASCII.GetBytes("RENAME,newhostname");

				sock.Send (data, data.Length, iep);
			}

			if (reboot >= 0 && reboot < mac_addresses.Length) {
				UdpClient sock = new UdpClient ();
				IPEndPoint iep = new IPEndPoint (IPAddress.Parse(mac_addresses[reboot].ip_address), 15001);

				byte[] data = Encoding.ASCII.GetBytes("REBOOT");

				sock.Send (data, data.Length, iep);
			}

			Console.ReadKey ();
		}
	}
}

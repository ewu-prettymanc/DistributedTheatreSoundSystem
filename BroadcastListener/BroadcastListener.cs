using System;
using System.Net.Sockets;
using System.Net;
using System.Text;
using System.Threading;
using System.Net.NetworkInformation;
using System.Diagnostics;

namespace Listeners
{
	class BroadcastListener
	{
		private static readonly int SLEEP_TIME = 5000;

		public static void Main (string[] args)
		{
			string address_info = "";
			bool flag = false;
			do {
				try {
					address_info = GetMacAddress ();
					flag = true;
				} catch (SocketException ex) {
					Console.WriteLine ("Issue recieving local address information");
					Thread.Sleep (SLEEP_TIME);
				}
			} while (!NetworkInterface.GetIsNetworkAvailable () || !flag);
			Console.WriteLine (address_info);

			UdpClient sock = new UdpClient (15001);
			IPEndPoint sender = new IPEndPoint (IPAddress.Any, 0); 

			sock.EnableBroadcast = true;

			byte[] data = new byte[1024];
			string string_data;

			while (true) {
				data = sock.Receive (ref sender);
				string_data = Encoding.ASCII.GetString (data);


				if (string_data == "PING") {
			//		Console.WriteLine ("RECIEVED PACKET");
					byte[] mac_data = Encoding.ASCII.GetBytes (address_info);
					sock.Send (mac_data, mac_data.Length, sender);
				} else if (string_data == "REBOOT")
					Reboot ();
				else {
					string[] split_data = string_data.Split (',');
					if (split_data [0] == "RENAME")
						RenameReboot (split_data [1]);
				}
			}
		}


		/*
		 * Now searches all network devices for a MAC and IP address, when it finds one that has both
		 * it returns those values. This will now grab both wireless and ethernet network interfaces.
		 * 
		 * Essentially, grabs first active networking interface. This should be fine for the raspberry pi's
		 * 	but I imagine there could be an issue if there are virtual network adapters (ie. virtual box adaptor, 
		 * 	vpn adapter).
		 */
		private static string GetMacAddress ()
		{
			string hostname = "", mac_address = "", ip_address = "";
			hostname = Dns.GetHostName ();
			foreach (NetworkInterface nic in NetworkInterface.GetAllNetworkInterfaces()) {
				mac_address = nic.GetPhysicalAddress ().ToString ();
				if (nic.OperationalStatus == OperationalStatus.Up) {
					foreach (UnicastIPAddressInformation ip in nic.GetIPProperties().UnicastAddresses) {
						if (ip.Address.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork) {
							ip_address = ip.Address.ToString ();
						}
						if (ip_address != "")
							break;
					}

				}
				if (mac_address != "" && ip_address != "")
					break;
			}
			//thrown if address information is lacking
			if (mac_address == "" || ip_address == "" || hostname == "")
				throw new SocketException ();
			return hostname + ',' + ip_address + ',' + mac_address;
		}
	
		//THE SCRIPT COULD REQUIRE ROOT ACCESS ON SOME OPERATING SYSTEMS
		//IF THE CONSOLE ENDS UP REQUESTING ROOT PERMISIONS YOU WILL NEED
		//TO ADD SUDO ACCESS FOR EVERYONE TO RUN WITH ROOT ACCESS
		private static void Reboot ()
		{
			ProcessStartInfo psi = new ProcessStartInfo ();
			psi.FileName = "/bin/bash";
			psi.Arguments = "../Scripts/reboot.sh";

			Process p = Process.Start (psi);
			p.WaitForExit ();
		}

		//THE SCRIPT REQUIRES ROOT PERMISSIONS, ADD SCRIPT
		//TO SUDOERS FILE FOR EVERYONE TO RUN WITH ROOT ACCESS
		private static void RenameReboot (string hostname)
		{
			ProcessStartInfo psi = new ProcessStartInfo ();
			psi.FileName = "/bin/bash";
			psi.Arguments = "../Scripts/change_hostname.sh " + hostname;

			Process p = Process.Start (psi);
			p.WaitForExit ();
		}
	}
}


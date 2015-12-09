using System.Diagnostics;
using System;

namespace Network
{
	public class SyncingLibrary {

		//CALL THIS WHEN THE CLIENT STARTS UP TO MAKE SURE ALL THE NODES ON THE NETWORK DON'T HAVE ANY NEWER FILES
		public static bool initialSync(Node[] nodes) {
			bool result = true;
			if (!syncToClient (nodes))
				result = false;
			if (!syncToServers (nodes))
				result = false;

			//if result is false an issue with rsync occured
			return result;
		}

		public static bool globalSync (Node[] nodes)
		{
			bool result = true;
			try {
				if (!syncToServers (nodes))
					result = false;
				if (!syncPasswords (nodes))
					result = false;
				if (!syncTrustedComputers (nodes))
					result = false;
			} catch (Exception e) {

			}
			//if result is false an issue with rsync occured
			return result;
		}

		public static bool syncToServers(Node[] nodes) {
			bool result = true;
			foreach (Node n in nodes) {
				if (!syncToServer (n))
					result = false;
			}
			return result;
		}


		public static bool syncToClient (Node[] nodes)
		{
			bool result = true;
			try {
				foreach (Node n in nodes) {
					if (!syncToClient (n))
						result = false;
				}
			} catch (Exception e) {
			}
			return result;
		}

		public static bool syncToClient(Node node) {
			string ip_address = node.getIP;
			ProcessStartInfo psi = new ProcessStartInfo ();
			psi.FileName = "/bin/bash";
			psi.Arguments = "../Scripts/sync_client.sh " + ip_address;

			Process p = Process.Start (psi);
			p.WaitForExit ();

			if (p.ExitCode == 0)
				return true;
			return false;
		}

		public static bool syncToServer(Node node) {
			string ip_address = node.getIP;
			ProcessStartInfo psi = new ProcessStartInfo ();

			psi.FileName = "/bin/bash";
			psi.Arguments = "../Scripts/sync_server.sh " + ip_address;

			Process p = Process.Start (psi);

			p.WaitForExit ();
			
			if (p.ExitCode == 0)
				return true;
			return false;
		}

		public static bool syncPasswords(Node[] nodes) {
			bool result = true;
			foreach (Node n in nodes) {
				if (!syncPasswords (n))
					result = false;
			}
			return result;
		}

		public static bool syncPasswords(Node node) {
			string ip_address = node.getIP;
			ProcessStartInfo psi = new ProcessStartInfo ();

			psi.FileName = "/bin/bash";
			psi.Arguments = "../Scripts/sync_passwords.sh " + ip_address;

			Process p = Process.Start (psi);

			p.WaitForExit ();

			if (p.ExitCode == 0)
				return true;
			return false;
		}

		public static bool syncTrustedComputers(Node[] nodes) {
			bool result = true;
			foreach (Node n in nodes) {
				if (!syncTrustedComputers (n))
					result = false;
			}
			return result;
		}

		public static bool syncTrustedComputers(Node node) {
			string ip_address = node.getIP;
			ProcessStartInfo psi = new ProcessStartInfo ();

			psi.FileName = "/bin/bash";
			psi.Arguments = "../Scripts/sync_trusted.sh " + ip_address;

			Process p = Process.Start (psi);

			p.WaitForExit ();

			if (p.ExitCode == 0)
				return true;
			return false;
		}
	}
}
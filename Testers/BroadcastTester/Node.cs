using System;

namespace Broadcaster
{
	public class Node
	{
		public string mac_address { get; set; }
		public string ip_address { get; set; } 
		public string hostname { get; set; }

		//used if data is ',' deliminated
		public Node (string data)
		{
			string[] parsed = data.Split (',');
			this.hostname = parsed [0];
			this.ip_address = parsed [1];
			this.mac_address = parsed [2];
		}

		public Node (string hostname, string ip_address, string mac_address)
		{
			this.hostname = hostname;
			this.ip_address = ip_address;
			this.mac_address = mac_address;
		}

		public string toString() {
			return this.hostname + "\n" + this.ip_address + "\n" + this.mac_address + "\n";
		}
	}
}


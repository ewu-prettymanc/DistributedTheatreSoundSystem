/*
 * This library is to be used to send commands accross the rPI network
 * 
 * Methods need a node or node array with IP address(es), filename(s), sound properties, and key names all at least initialized to a default value.
 * 
 * Notes:
 * 	Cues should call using the methods with arrays as parameters, even if only one Node is in a cue.
 * 	
*/

using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
namespace Network
{
	public class CommandSenderLibrary
	{
		public static readonly int BROADCAST_PORT = 15001;
		public static readonly int COMMAND_PORT = 15002;
		public static readonly string STOP_ALL = "STOPALL";
		public static readonly string PAUSE_ALL = "PAUSEALL";
		public static readonly string GLOBAL_VOLUME = "GLOBALVOLUME";
		public static readonly string PLAY_ALL = "PLAYALL";
		public static readonly string RESUME_ALL = "RESUMEALL";
		public static readonly string TEST_MESSAGE = "START,test_sound_-1111,test_sound.wav,0,0,0,10,0";

		public static void SendStart(Node[] nodes) {
			UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (nodes [i].StartMessage());
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendPause(Node[] nodes) {
			UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (nodes [i].PauseMessage());
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendPauseAll(Node[] nodes) {
		  UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (PAUSE_ALL);
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendPauseAll(Node node) {
			UdpClient sock = new UdpClient();
			IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP),COMMAND_PORT);
			byte[] data = Encoding.ASCII.GetBytes (PAUSE_ALL);
			sock.Send(data, data.Length, iep);
			sock.Close();	
		}

		public static void SendStop(Node[] nodes) {
			UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (nodes [i].StopMessage());
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendStopAll(Node[] nodes) {
			UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (STOP_ALL);
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendStopAll(Node node) {
			UdpClient sock = new UdpClient();
			IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP),COMMAND_PORT);
			byte[] data = Encoding.ASCII.GetBytes (STOP_ALL);
			sock.Send(data, data.Length, iep);
			sock.Close();	
		}
		
		public static void SendStopAll(String ip) {
		  UdpClient sock = new UdpClient();
		  IPEndPoint iep = new IPEndPoint(IPAddress.Parse(ip), BROADCAST_PORT);
		  byte[] message = Encoding.ASCII.GetBytes(STOP_ALL);
		  sock.Send(message, message.Length, iep);
		  sock.Close();
		}

		public static void SendPlayAll(Node[] nodes) {
		UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (PLAY_ALL);
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendPlayAll(Node node) {
			UdpClient sock = new UdpClient();
			IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP),COMMAND_PORT);
			byte[] data = Encoding.ASCII.GetBytes (PLAY_ALL);
			sock.Send(data, data.Length, iep);
			sock.Close();	
		}

		public static void SendResume(Node[] nodes) {
			UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (nodes [i].ResumeMessage());
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendResumeAll(Node[] nodes) {
		UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (RESUME_ALL);
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendResumeAll(Node node) {
			UdpClient sock = new UdpClient();
			IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP),COMMAND_PORT);
			byte[] data = Encoding.ASCII.GetBytes (RESUME_ALL);
			sock.Send(data, data.Length, iep);
			sock.Close();	
		}

		public static void SendVolume(Node[] nodes) {
			UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (nodes [i].VolumeMessage());
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();
		}

		public static void SendVolume(Node node) {
			UdpClient sock = new UdpClient ();
			IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP),COMMAND_PORT);
			byte[] message = Encoding.ASCII.GetBytes (node.VolumeMessage ());
			sock.Send (message, message.Length, iep);
			sock.Close ();
		}
		
		public static void SendGlobalVolume(Node[] nodes, String newvolume) {
			UdpClient sock = new UdpClient ();
			IPEndPoint[] ieps = new IPEndPoint[nodes.Length];
			byte[][] messages = new byte[nodes.Length][];

			int i = 0;
			for (; i < ieps.Length; i++) {
				ieps [i] = new IPEndPoint (IPAddress.Parse (nodes [i].getIP), COMMAND_PORT);
				messages [i] = Encoding.ASCII.GetBytes (GLOBAL_VOLUME + "," + newvolume);
			}
			for (i = 0; i < ieps.Length; i++)
				sock.Send (messages [i], messages [i].Length, ieps [i]);
			sock.Close ();			
		}

		public static void TestNode(Node node) {
			UdpClient sock = new UdpClient ();
			IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP),COMMAND_PORT);
			byte[] message = Encoding.ASCII.GetBytes (TEST_MESSAGE);
			sock.Send (message, message.Length, iep);
			sock.Close ();
		}
		
		public static void TestNode(String ip) {
			UdpClient sock = new UdpClient ();
			IPEndPoint iep = new IPEndPoint(IPAddress.Parse(ip),COMMAND_PORT);
			byte[] message = Encoding.ASCII.GetBytes (TEST_MESSAGE);
			sock.Send (message, message.Length, iep);
			sock.Close ();
		}
		
		public static void SendRenameReboot(Node node, string name) {
		  UdpClient sock = new UdpClient();
		  IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP), BROADCAST_PORT);
		  byte[] message = Encoding.ASCII.GetBytes("RENAME," + name);
		  sock.Send(message, message.Length, iep);
		  sock.Close();
		}
		
		public static void SendRenameReboot(String ip, string name) {
		  UdpClient sock = new UdpClient();
		  IPEndPoint iep = new IPEndPoint(IPAddress.Parse(ip), BROADCAST_PORT);
		  byte[] message = Encoding.ASCII.GetBytes("RENAME," + name);
		  sock.Send(message, message.Length, iep);
		  sock.Close();
		}

		public static void SendReboot(Node node) {
		  UdpClient sock = new UdpClient();
		  IPEndPoint iep = new IPEndPoint(IPAddress.Parse(node.getIP), BROADCAST_PORT);
		  byte[] message = Encoding.ASCII.GetBytes("REBOOT");
		  sock.Send(message, message.Length, iep);
		  sock.Close();
		}
		
		public static void SendReboot(String ip) {
		  UdpClient sock = new UdpClient();
		  IPEndPoint iep = new IPEndPoint(IPAddress.Parse(ip), BROADCAST_PORT);
		  byte[] message = Encoding.ASCII.GetBytes("REBOOT");
		  sock.Send(message, message.Length, iep);
		  sock.Close();
		}
	}
}
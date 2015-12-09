using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

namespace CommandTester
{
	class MainClass
	{
		//ADJUST THESE BASED ON TESTING 
		private static string song1 = "productions/new blah/sounds/Seagull.mp3";
		private static string song2 = "productions/Lord of the Tacos/sounds/CarStarting.mp3";
		private static string song3 = "productions/new blah/sounds/chewie.wav";
		private static string song4 = "productions/Lord of the Tacos/sounds/chewie.wav";

		//private static string ip_address = "255.255.255.255";//10.0.2.15";
		private static string ip_address = "192.168.1.165";
		public static void Main (string[] args)
		{
			UdpClient sock = new UdpClient ();
			IPEndPoint iep = new IPEndPoint (IPAddress.Parse (ip_address), 15002);

			byte[] data = null;

			int option = menu ();
			String song;
			while (option != 0) {
				switch(option) {
					case 1:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("START,"+ song + "," + song + "," + 200 + "," + 1300 + 
						                               "," + 0 + "," + 10 + "," + 0);
						sock.Send (data, data.Length, iep);
						break;
					case 2:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("STOP," + song);
						break;
					case 3:
						data = Encoding.ASCII.GetBytes("STOPALL");
						break;
					case 4:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("PAUSE," + song);
						break;
					case 5:
						data = Encoding.ASCII.GetBytes("PAUSEALL");
						break;
					case 6:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("VOLUME," + song + "," + getVolume() );
						break;
					case 7:
						data = Encoding.ASCII.GetBytes("VOLUMEALL," + getVolume() );
						break;
					case 8:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("PLAY," + song);
						break;
					case 9:
						data = Encoding.ASCII.GetBytes("PLAYALL");
						break;
					case 10:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("RESUME," + song);
						break;
					case 11:
						data = Encoding.ASCII.GetBytes("RESUMEALL");
						break;
					case 12:
						data = Encoding.ASCII.GetBytes ("GLOBALVOLUME," + getVolume ());
						break;
					case 13:
						data = Encoding.ASCII.GetBytes ("GETTIMEINFO," + getSong ());
						DurationListener d = new DurationListener ();
						Thread t = new Thread (new ThreadStart (d.Run));
						t.Start ();
						break;
					case 14:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("PITCH," + song + "," + getPitch() );
						break;
					case 15:
						data = Encoding.ASCII.GetBytes("PITCHALL" + "," + getPitch());
						break;
					case 16:
						song = getSong ();
						data = Encoding.ASCII.GetBytes("TEMPO," + song + "," + getPitch() );
						break;
					case 17:
						data = Encoding.ASCII.GetBytes("TEMPOALL" + "," + getPitch());
						break;
				} // end switch

				sock.Send(data,data.Length,iep);
				option = menu ();
			}

		}

		private static int menu() {
			Console.WriteLine ("\n1) START packet");
			Console.WriteLine ("2) STOP packet");
			Console.WriteLine ("3) STOPALL packet");
			Console.WriteLine ("4) PAUSE packet");
			Console.WriteLine ("5) PAUSEALL packet ");
			Console.WriteLine ("6) VOLUME packet");
			Console.WriteLine ("7) VOLUMEALL packet");
			Console.WriteLine ("8) PLAY packet");
			Console.WriteLine ("9) PLAYALL packet");
			Console.WriteLine ("10) RESUME packet");
			Console.WriteLine ("11) RESUMEALL packet");
			Console.WriteLine ("12 GLOBALVOLUME packet");
			Console.WriteLine ("13 TIMEINFO packet");
			Console.WriteLine ("14 PITCH packet");
			Console.WriteLine ("15 PITCHALL packet");
			Console.WriteLine ("16 TEMPO packet");
			Console.WriteLine ("17 TEMPOALL packet");


			Console.WriteLine ("0) EXIT");

			int option = -1;
			while (option < 0 || option > 17) {
				Console.Write ("Enter option: ");
				option = Convert.ToInt32(Console.ReadLine ());
				Console.WriteLine ();
			}
			return option;
		}

		private static int getVolume() {
			Console.Write("Enter the volume 0-100%: ");
			return Convert.ToInt32 (Console.ReadLine ());
		}

		private static double getPitch() {
			Console.Write("Enter the Pitch/Tempo: ");
			return Convert.ToDouble (Console.ReadLine ());
		}

		private static String getSong() {
			Console.WriteLine ("\n1) " + song1);
			Console.WriteLine ("2) " + song2);
			Console.WriteLine ("3) " + song3);
			Console.WriteLine ("4) " + song4);

			Console.Write("Enter option: ");
			int choice = Convert.ToInt32 (Console.ReadLine ());

			String res="";

			switch (choice) {
			case 1: 
				res = song1;
				break;
			case 2: 
				res = song2;
				break;
			case 3:
				res = song3;
				break;
			case 4: 
				res = song4;
				break;
			}

			return res;
		}
	}
}

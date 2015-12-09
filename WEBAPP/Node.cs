using System;

namespace Network
{
	public class Node
	{
		private double volume;
		private int delay;
		private int fadeIn;
		private int fadeOut;
		private double shiftPitch;
		private string sound;
		private string ip;
		private string mac;
		private string name;
		private bool active;

		//Key creation needs to be flushed out
		private string key;

		public Node (double vol, int del, int fin, int fout, double shift, string sound)
		{
			this.volume = vol;
			this.delay = del;
			this.fadeIn = fin;
			this.fadeOut = fout;
			this.shiftPitch = shift;
			this.sound = sound;
		}

		public Node (string ip, string mac, string name)
		{
			this.ip = ip;
			this.mac = mac;
			this.name = name;
			this.volume = 50; // 0-100
			this.delay = 0; // > 0
			this.fadeIn = 0; // > 0
			this.fadeOut = 0; // > 0
			this.shiftPitch = 0; // -10-10
			this.sound = null;
			this.active = false;
		}

		public Node (string data)
		{
			string[] parsed = data.Split (',');
			this.name = parsed [0];
			this.ip = parsed [1];
			this.mac = parsed [2];
		}

		public string Sound { set { this.sound = value; } get { return this.sound; } }

		public double Volume { set { this.volume = value; } get { return this.volume; } }

		public int Delay { set { this.delay = value; } get { return this.delay; } }

		public int FadeIn { set { this.fadeIn = value; } get { return this.fadeIn; } }

		public int FadeOut { set { this.fadeOut = value; } get { return this.fadeOut; } }

		public double ShiftPitch { set { this.shiftPitch = value; } get { return this.shiftPitch; } }

		public bool getActive { set { this.active = value; } get { return this.active; } }

		public string getIP { set { this.ip = value; } get { return this.ip; } }

		public string getMac { set { this.mac = value; } get { return this.mac; } }

		public string getName { set { this.name = value; } get { return this.name; } }
		
		public string getKey {set {this.key = value;} get { return this.key;} } 

		public string StartMessage ()
		{
			/*
			return "START" + ',' +
				this.key + ',' +
				this.sound + ',' +
				this.fadeIn + ',' +
				this.fadeOut + ',' +
				this.delay + ',' +
				this.volume + ',' +
	STILL NEED VALUES FOR DISTANCE, POSITION, AND LOOPS
			
			*/
			// [START, key, fname, fadein, fadeout, delay, volume, pitch ]
			return "START" + ',' +
				this.key + ',' +
				this.sound + ',' +
				this.fadeIn + ',' +
				this.fadeOut + ',' + 
				this.delay + ',' +
				this.volume + ',' +
				this.shiftPitch;
	
		}

		/// <summary>
		/// Pauses this cue
		/// </summary>
		/// <returns>The message.</returns>
		public string PauseMessage ()
		{
			return "PAUSE" + ',' +
			this.key + ',' +
			this.sound;
		}

		/// <summary>
		/// Stops this cue
		/// </summary>
		/// <returns>The message.</returns>
		public string StopMessage ()
		{
			return "STOP" + ',' +
			this.key;
		}
			
		/// <summary>
		/// Resumes this cue
		/// </summary>
		/// <returns>The message.</returns>
		public string ResumeMessage ()
		{
			return "RESUME" + ',' +
			this.key;
		}

		/// <summary>
		/// Volumes for this cue.
		/// </summary>
		/// <returns>The message.</returns>
		public string VolumeMessage ()
		{
			return "VOLUME" + ',' +
			this.key + ',' +
			this.volume;
		}

		public string PitchMessage ()
		{
			return "PITCH" + ',' +
				this.key + ',' +
				this.shiftPitch;
		}

		public string TestMessage() {
			return "";
		}
	}
}


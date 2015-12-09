//Jared Hutton
//Fall 2014 - Winter 2015
//Senior Project EWU
//Team 6

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Collections.Generic;
using System.Collections;
using System.Threading;

namespace Network
{
	public partial class ControllerPage : System.Web.UI.Page
	{
		private static string[] cueArray;
		private static string[] nodeArray;
		private static string[] effectArray;
		private static string[] soundArray;
		private static ArrayList NodeList;
		private static Broadcaster bc;
		private static Thread t;

		protected void Page_Load (object sender, EventArgs e)
		{
			if((string)Session["UserType"] != "Admin" && (string)Session["UserType"] != "User")
				Response.Redirect("Default.aspx");
			bc = new Broadcaster();
			NodeList = FileMethods.readNodeFile ();//reads data from nodes.txt
		}

		[WebMethod]
		public static string[] getCueArray ()
		{
			return cueArray;
		}

		[WebMethod]
		public static string[] getNodeArray ()
		{
			return nodeArray;
		}

		[WebMethod]
		public static string[] getEffectArray()
		{
			return effectArray;
		}

		[WebMethod]
		public static string[] getSoundArray()
		{
			return soundArray;
		}

		[WebMethod]
		public static ArrayList getNodeList ()
		{
			findActiveNodes();
			return NodeList;
		}

		//Kills the broadcaster thread
		[WebMethod]
		public static void killBroadcaster ()
		{
			bc.killThread();
		}

		//Populates arrays based on the requested production.
		[WebMethod (EnableSession = true)]
		public static void loadProduction(string name)
		{
			Page page = new ControllerPage();
			page.Session["ProdName"] = name;
			ArrayList list = FileMethods.readProduction(name);
			cueArray = (string[])list[0];
			nodeArray = (string[])list[1];
			effectArray = (string[])list[2];
			soundArray = (string[])list[3];
		}

		//This method updates the NodeList to reflect active nodes flag as true
		//overwrites name and IP to get the new updated info if there is any
		//It also writes new nodes found in the active list to text/nodes
		private static void findActiveNodes ()
		{
			//Test gives it an active node
			//ActiveNodes = new Node[2];
			//Node newNode1 = new Node ("192.168.1.5", "mac", "Node1"); 
			//ActiveNodes[0] = newNode1;
			//Node newNode2 = new Node ("192.168.1.55", "mac44", "Node22"); 
			//ActiveNodes[1] = newNode2;
			//End Test

			Node[] ActiveNodes = bc.refresh();

			foreach(Node taco in NodeList)
				taco.getActive = false;

			foreach (Node active in ActiveNodes) 
			{
				bool newNode = true;
				foreach (Node node in NodeList){
					if(active.getMac.Equals(node.getMac)){
						node.getActive = true;
						if(node.getIP != active.getIP || node.getName != active.getName){
							FileMethods.renameNode(active.getIP, node.getIP, active.getName, node.getName);
							node.getIP = active.getIP;
							node.getName = active.getName;
						}
						newNode = false;
					}
				}
				if(newNode){
					FileMethods.writeNew("text/nodes", active.getIP + " " + active.getMac + " " + active.getName);
					NodeList.Add(active);
				}
			}
		}

		//Gets a list of productions that have been saved.
		[WebMethod]
		public static string[] getProductions()
		{
			string[] files = FileMethods.getDirectoryFolderNames("productions");
			return files;
		}

		//gets a list of sound names from a production
		[WebMethod]
		public static string[] getSoundNames (string name)
		{
			string[] files = FileMethods.getSoundNames(name);
			return files;
		}

		//Plays the attached sound on the list of nodes that was brought in.
		[WebMethod]
		public static void startSound (object nodes, string prodName)
		{
			ArrayList send = new ArrayList ();
			ArrayList list = (ArrayList)nodes;
			send = createNodeList(list, send, prodName);
			CommandSenderLibrary.SendStart((Node[])send.ToArray(typeof(Node)));
		}

		//Pauses the attached sound on the list of nodes that was brought in.
		[WebMethod]
		public static void pauseSound (object nodes, string prodName)
		{
			ArrayList send = new ArrayList ();
			ArrayList list = (ArrayList)nodes;
			send = createNodeList(list, send, prodName);
			CommandSenderLibrary.SendPause((Node[])send.ToArray(typeof(Node)));
		}

		//Stops the attached sound on the list of nodes that was brought in.
		[WebMethod]
		public static void stopSound (object nodes, string prodName)
		{
			ArrayList send = new ArrayList ();
			ArrayList list = (ArrayList)nodes;
			send = createNodeList(list, send, prodName);
			CommandSenderLibrary.SendStop((Node[])send.ToArray(typeof(Node)));
		}

		//Resume sound on all nodes passed in
		[WebMethod]
		public static void resumeSound (object nodes, string prodName)
		{
			ArrayList send = new ArrayList ();
			ArrayList list = (ArrayList)nodes;
			send = createNodeList(list, send, prodName);
			CommandSenderLibrary.SendResume((Node[])send.ToArray(typeof(Node)));
		}

		//Creates a new node from the dictionary object and puts it in the passed in ArrayList
		private static ArrayList createNodeList (ArrayList list, ArrayList send, string prodName)
		{
			try {
				foreach (Dictionary<string, object> oldNode in list) {
					foreach (Node node in NodeList) {
						if (node.getName == oldNode ["name"].ToString()) {
							Node newNode = new Node (node.getIP, node.getMac, node.getName);
							newNode.Volume = Double.Parse (oldNode ["volume"].ToString());
							newNode.FadeIn = Int32.Parse (oldNode ["fadein"].ToString());
							newNode.FadeOut = Int32.Parse (oldNode ["fadeout"].ToString());
							newNode.ShiftPitch = Double.Parse (oldNode ["pitch"].ToString());
							newNode.Delay = Int32.Parse (oldNode ["delay"].ToString());
							newNode.Sound = "productions/" + prodName + "/sounds/" + oldNode ["sound"].ToString();
							newNode.getKey = oldNode ["key"].ToString();
							send.Add (newNode);
						}
					}
				}
			} catch (Exception e) {
			}
			return send;
		}

		//Resume all sounds on all nodes passed in
		[WebMethod]
		public static void sendResumeAll (object nodes, string prodName)
		{
			ArrayList send = new ArrayList ();
			ArrayList nodelist = (ArrayList)nodes;
			foreach (ArrayList list in nodelist) 
			{
				send = createNodeList(list, send, prodName);
			}
			CommandSenderLibrary.SendResumeAll((Node[])send.ToArray(typeof(Node)));
		}

		//Pause all sounds on all nodes passed in
		[WebMethod]
		public static void sendPauseAll (object nodes, string prodName)
		{
			ArrayList send = new ArrayList ();
			ArrayList nodelist = (ArrayList)nodes;
			foreach (ArrayList list in nodelist) 
			{
				send = createNodeList(list, send, prodName);
			}
			CommandSenderLibrary.SendPauseAll((Node[])send.ToArray(typeof(Node)));
		}

		//Stop all sounds on all nodes passed in
		[WebMethod]
		public static void sendStopAll (object nodes, string prodName)
		{
			ArrayList send = new ArrayList ();
			ArrayList nodelist = (ArrayList)nodes;
			foreach (ArrayList list in nodelist) 
			{
				send = createNodeList(list, send, prodName);
			}
			CommandSenderLibrary.SendStopAll((Node[])send.ToArray(typeof(Node)));
		}

		//Creates a production folder from passed in name and other default folders/files
		[WebMethod]
		public static void createProduction (string pass, string name)
		{
			FileMethods.createProduction(pass, name);
		}

		//Deletes a production folder from passed in name
		[WebMethod]
		public static string deleteProduction (string name)
		{
			string pass = FileMethods.deleteProduction(name, true);
			return pass;
		}

		//Deletes a production folder from passed in name and password
		[WebMethod]
		public static void deleteProductionPass (string name)
		{
			FileMethods.deleteProduction(name, false);
		}

		//Checks file for password and if it does returns it or returns black string if not
		[WebMethod]
		public static string checkProdPass(string name){
			string pass = FileMethods.checkProdPass(name);
			return pass;
		}

		//Save the new cue to the production file
		[WebMethod]
		public static void saveAddCue(string name, string sound, string prodName)
		{
			FileMethods.saveAddCue(name, sound, prodName);
		}

		//Save the cue edits passed in to the production file
		[WebMethod]
		public static void saveCueEdits(string name, string sound, string prodName, string oldname)
		{
			FileMethods.saveCueEdits(name, sound, prodName, oldname);
		}

		//Save the new node to the cue in the production file
		[WebMethod]
		public static void saveAddNode (string name, string prodName, string cueName)
		{
			FileMethods.saveAddNode(name, prodName, cueName);
		}

		//Deletes the cue from the production file
		[WebMethod]
		public static void saveDeleteCue (string name, string prodName)
		{
			FileMethods.saveDeleteCue(name, prodName);
		}

		//Deletes the node from the cue in the production file
		[WebMethod]
		public static void saveDeleteNode (string nodeName, string cueName, string prodName)
		{
			FileMethods.saveDeleteNode(nodeName, cueName, prodName);
		}

		//Checks of all nodes in nodeArray are online and returns true if so
		[WebMethod]
		public static bool checkNodesOnline (object nodes)
		{
			ArrayList names = new ArrayList();
			Node[] ActiveNodes = bc.refresh();
			foreach (Node bacon in ActiveNodes)
				names.Add(bacon.getName);

			ArrayList nodelist = (ArrayList)nodes;
			foreach (Dictionary<string, object> list in nodelist) 
			{
				if(!(names.Contains((string)list["name"])))
					return false;
			}
			return true;
		}

		//Checks if sound exists
		[WebMethod]
		public static bool checkSound(string sound, string prodName)
		{
			return FileMethods.checkSound(sound, prodName);
		}

		//Saves node effect to file
		[WebMethod]
		public static void saveNodeEffects(object nodes, string prodName, string cueName)
		{
			Dictionary<string, object> taco= (Dictionary<string, object>)nodes;
			FileMethods.saveNodeEffects((string)taco["name"], (string)taco["volume"], 
			                            (string)taco["fadein"], (string)taco["fadeout"], 
			                            (string)taco["pitch"], (string)taco["delay"], 
			                            prodName, cueName);
		}

		//Saves moving a cue up in the production
		[WebMethod]
		public static void saveMoveCueUporDown(string bottomCueName, string topCueName, string prodName){
			FileMethods.saveMoveCueUporDown(bottomCueName, topCueName, prodName);
		}

		//Gets time remaining for a sound
		[WebMethod]
		public static int getSoundLength (string sound, string prodName)
		{
			double taco = AudioInfo.GetLength("productions/" + prodName + "/sounds/" + sound);
			int time = Convert.ToInt32(Math.Round(taco));
			return time;
		}

		//Changes global volume
		[WebMethod]
		public static void changeGlobalVolume (string level)
		{
			Node[] ActiveNodes = bc.refresh();
			CommandSenderLibrary.SendGlobalVolume(ActiveNodes, level);
		}

		//Initial sync of productions, sounds, password file and trusted computer file
		[WebMethod]
		public static void initialSync ()
		{
			try {
				t = new Thread (new ThreadStart (() => SyncingLibrary.syncToClient (bc.refresh ())));
				t.Start ();
			} catch (Exception e) {

			}
		}

		//Pushes sync of all files
		[WebMethod]
		public static void regularSync ()
		{
			try{
				if (t.IsAlive == false) {
					t = new Thread(new ThreadStart(() => SyncingLibrary.globalSync(bc.refresh())));
					t.Start();
				}
			}
			catch(Exception e){

			}
		}
	}
}
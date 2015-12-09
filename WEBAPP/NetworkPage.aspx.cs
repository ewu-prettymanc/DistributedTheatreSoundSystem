
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Collections;
using System.Net;

namespace Network
{
	public partial class NetworkPage : System.Web.UI.Page
	{

		private static ArrayList NodeList;
		private static Node[] ActiveNodesold;//Delete
		private static Broadcaster bc;
		private static string[] NodeNames;
		private static string[] NodeMacs;
		private static string[] NodeIPs;
		private static bool[] NodeActive;

		protected void Page_Load (object sender, EventArgs e)
		{
			bc = new Broadcaster();
			if((string)Session["UserType"] != "Admin")
				Response.Redirect("Default.aspx");
			NodeList = FileMethods.readNodeFile ();//reads data from nodes.txt
		}

		[WebMethod]
		public static Node[] getActive()
		{
			return bc.refresh();
		}

		[WebMethod]
		public static string[] getNodeNames()
		{
			return NodeNames;
		}

		[WebMethod]
		public static string[] getNodeMacs()
		{
			return NodeMacs;
		}

		[WebMethod]
		public static string[] getNodeIPs()
		{
			return NodeIPs;
		}

		[WebMethod]
		public static bool[] getNodeActive()
		{
			return NodeActive;
		}

		//Kills the broadcaster thread
		[WebMethod]
		public static void killBroadcaster ()
		{
			bc.killThread();
		}

		[WebMethod]
		public static void makeArrays()
		{
			findActiveNodes();

			NodeNames = new string[NodeList.Count];
			NodeMacs = new string[NodeList.Count];
			NodeIPs = new string[NodeList.Count];
			NodeActive = new bool[NodeList.Count];
			int count = 0;
			foreach (Node node in NodeList) //This gets all info from nodes and puts them in arrays to be used by javascript
			{
				NodeNames[count] = node.getName;
				NodeMacs[count] = node.getMac;
				NodeIPs[count] = node.getIP;
				NodeActive[count] = node.getActive;
				count++;
			}
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

		//This method is called from Javascript and is passed the mac address of the Node it wants to delete from text/nodes
		[WebMethod]
		public static void deleteNode (string mac)
		{
			Node temp = null;
			foreach (Node node in NodeList) {
				if(node.getMac.Equals(mac))
					temp = node;
			}
			if(temp != null)
				NodeList.Remove(temp);
			FileMethods.deleteNode(mac);
			makeArrays();
		}

		//Gets an array created in another method that has all the hostnames in the text/trusted file and 
		[WebMethod]
		public static string[] getTrusted ()
		{
			string[] trustedArray = null;
			trustedArray = FileMethods.getTrusted();
			return trustedArray;
		}

		//Deletes a hostname from the text/trusted file
		[WebMethod]
		public static void deleteTrusted (string name)
		{
			FileMethods.deleteTrusted(name);
		}

		//Takes the IP from the asp page and resolves a hostname from DNS and passes it back
		[WebMethod]
		public static string getUserIP ()
		{
			try {
				string ip = System.Web.HttpContext.Current.Request.ServerVariables ["HTTP_X_FORWARDED_FOR"] ?? System.Web.HttpContext.Current.Request.ServerVariables ["REMOTE_ADDR"];    
				IPAddress myIP = IPAddress.Parse (ip);
				IPHostEntry GetIPHost = Dns.GetHostEntry (myIP);
				return GetIPHost.HostName.ToString ();
			} catch (Exception e) {
				return e.ToString();
			}

		}

		//Writes a hostname to the text/trusted file
		[WebMethod]
		public static string writeTrusted (string hostname)
		{
			string[] trustedArray = FileMethods.getTrusted ();
			string myReturn = "";
			Boolean trusted = false;
			foreach (string trustedNode in trustedArray) {
				if (hostname.Equals (trustedNode)) {
					myReturn = "Your computer was already trusted.";
					trusted = true;
				}
			}
			if (!trusted) 
			{ FileMethods.writeNew ("text/trusted", hostname); }
			return myReturn;
		}

		//writes new password down
		[WebMethod]
		public static bool writePassword (string user, string pass)
		{
			return FileMethods.checkPass(user, pass);
		}

		//Reboots a node 
		[WebMethod]
		public static void rebootNode (string ip)
		{
			CommandSenderLibrary.SendReboot(ip);
			Node[] ActiveNodes = bc.refresh();
			Node[] newActiveNodes = new Node[ActiveNodes.Length];
			bool[] newNodeActive = new bool[NodeActive.Length];
			int count = 0;
			for(int i = 0; i < ActiveNodes.Length; i++) {
				if (ActiveNodes[i].getIP != ip){
					newActiveNodes[count] = ActiveNodes[i];
					newNodeActive[count] = NodeActive[i];
					count++;
				}
			}
			ActiveNodes = newActiveNodes;
			NodeActive = newNodeActive;
		}

		//Node plays a test sound
		[WebMethod]
		public static void testNode (string ip)
		{
			CommandSenderLibrary.TestNode(ip);
		}

		//Renames a node, changes it in text/nodes file and in the nodelist and then reboots node.
		[WebMethod]
		public static void renameNode (string ip, string newName, string oldName)
		{
			CommandSenderLibrary.SendRenameReboot (ip, newName);
			FileMethods.renameNode (ip, ip, newName, oldName);
			foreach (Node node in NodeList) {
				if (node.getIP == ip && node.getName == oldName)
					node.getName = newName;
			}
			Node[] ActiveNodes = bc.refresh();
			Node[] newActiveNodes = new Node[ActiveNodes.Length];
			bool[] newNodeActive = new bool[NodeActive.Length];
			int count = 0;
			for(int i = 0; i < ActiveNodes.Length; i++) {
				if (ActiveNodes[i].getIP != ip && ActiveNodes[i].getName != oldName){
					newActiveNodes[count] = ActiveNodes[i];
					newNodeActive[count] = NodeActive[i];
					count++;
				}
			}
			ActiveNodes = null;
			ActiveNodes = newActiveNodes;
			NodeActive = newNodeActive;
			for(int i = 0; i < NodeNames.Length; i++){
				if(NodeNames[i] == oldName)
					NodeNames[i] = newName;
			}
		}
	}
}
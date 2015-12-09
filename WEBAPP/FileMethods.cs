//Jared Hutton
//Fall 2014 - Winter 2015
//Senior Project EWU
//Team 6

using System;
using System.Collections;
using System.IO;
using System.Linq;
using System.Web.Services;

namespace Network
{
	public class FileMethods
	{
		//Reads from text/nodes and creates a linkedlist of nodes in the file and returns it
		public static ArrayList readNodeFile()
		{
			ArrayList list = new ArrayList();
			//list = Test(list);//test

			try
            {
                using (StreamReader sr = new StreamReader("text/nodes"))
                {
                    String node;
                    while((node = sr.ReadLine()) != null)
                    {
						int firstsp = node.IndexOf(" ");
						int lastsp = node.LastIndexOf(" ");
						Node newNode = new Node(node.Substring(0, firstsp), 
						                        node.Substring(firstsp + 1, lastsp - firstsp - 1), 
						                        node.Substring(lastsp + 1, node.Length -lastsp - 1));
						list.Add(newNode);
                    }
                    sr.Close();
                }
            }
            catch (Exception e)
            {
                WriteLog(e);
            }


			return list;
		}

		//This method is for testing purposes dummy node linked list
		private static ArrayList Test (ArrayList list)
		{
			Node newNode = new Node ("192.168.1.5", "mac", "Node1"); 
			Node newNode1 = new Node ("192.168.1.6", "mac1", "Node2"); 
			list.Add(newNode);
			list.Add(newNode1);
			return list;
		}

		//Writes errors to a text/log
		public static void WriteLog (Exception e)
		{
			try
            {
                System.IO.File.AppendAllText("text/log", "\n\n" + e.ToString());

            }
            catch (Exception){}
		}

		public static void deleteNode (string mac)
		{
			try
            {
				String newList = "";
                using (StreamReader sr = new StreamReader("text/nodes"))
                {
                    String node;
                    while((node = sr.ReadLine()) != null)
                    {
						int firstsp = node.IndexOf(" ");
						int lastsp = node.LastIndexOf(" ");
						if(!(mac.Equals(node.Substring(firstsp + 1, lastsp - firstsp - 1))))
						   newList = newList + node + "\n";
                    }
                    sr.Close();
                }
				System.IO.File.WriteAllText ("text/nodes", newList);
            }
            catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static void renameNode (string newip, string oldip, string newName, string oldName)
		{
			try
            {
				String newList = "";
                using (StreamReader sr = new StreamReader("text/nodes"))
                {
                    String node;
                    while((node = sr.ReadLine()) != null)
                    {
						int firstsp = node.IndexOf(" ");
						int lastsp = node.LastIndexOf(" ");
						if(oldip.Equals(node.Substring(0, firstsp)) && oldName.Equals(node.Substring(lastsp + 1)))
						    newList = newList + newip + node.Substring(firstsp, lastsp - firstsp + 1) + newName + "\n";
						else
							newList = newList + node + "\n";
                    }
                    sr.Close();
                }
				System.IO.File.WriteAllText ("text/nodes", newList);
            }
            catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static string[] getTrusted(){
			ArrayList list = new ArrayList();
			try
            {
                using (StreamReader sr = new StreamReader("text/trusted"))
                {
                    String line;
                    while((line = sr.ReadLine()) != null)
                    {
						list.Add(line);
                    }
                    sr.Close();
                }
            }
            catch (Exception e)
            {
                WriteLog(e);
            }
			string[] trustedArray = (string[])list.ToArray(typeof(string));
			return trustedArray;
		}
	

		public static void deleteTrusted (string name)
		{
			try
            {
				String newList = "";
                using (StreamReader sr = new StreamReader("text/trusted"))
                {
                    String node;
                    while((node = sr.ReadLine()) != null)
                    {
						if(!(name.Equals(node)))
						   newList = newList + node + "\n";
                    }
                    sr.Close();
                }
				System.IO.File.WriteAllText ("text/trusted", newList);
            }
            catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static void writeNew(string filename, string writetext){
			try
            {
                System.IO.File.AppendAllText(filename, writetext + "\n");

            }
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static void writeNewNode(Node newNode){
			try
            {
                System.IO.File.AppendAllText("text/nodes", newNode.getIP + " " + newNode.getMac + " " + newNode.getName);

            }
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static ArrayList readProduction(string filename)
		{
			ArrayList list = new ArrayList();
			ArrayList cueList = new ArrayList();
			ArrayList nodeList = new ArrayList();
			ArrayList effectList = new ArrayList();
			ArrayList soundList = new ArrayList();
			try
            {
                using (StreamReader sr = new StreamReader("productions/" + filename + "/" + filename))
                {
                    String line = sr.ReadLine();
                    while((line = sr.ReadLine()) != null)
                    {
						cueList.Add(line);
						line = sr.ReadLine();
						soundList.Add(line);
						int nodenum = 0;
						nodeList.Add("test&*99");
						while((line = sr.ReadLine()) != "" && line != null)
						{
							nodeList.Add(line);
							for(int i = 0; i < 5; i++)
							{
								line = sr.ReadLine();
								effectList.Add(line);
							}
							nodenum++;
						}
						if(nodenum == 0){
							int index = nodeList.IndexOf("test&*99");
							nodeList.RemoveAt(index);
							nodeList.Insert(index, "0");
						}
						else
						{
							int index = nodeList.IndexOf("test&*99");
							nodeList.RemoveAt(index);
							nodeList.Insert(index, nodenum + "");
						}
                    }
                    sr.Close();
                }
            }
            catch (Exception e)
            {
                WriteLog(e);
            }
			string[] cueArray = (string[])cueList.ToArray(typeof(string));
			string[] nodeArray = (string[])nodeList.ToArray(typeof(string));
			string[] effectArray = (string[])effectList.ToArray(typeof(string));
			string[] soundArray = (string[])soundList.ToArray(typeof(string));
			list.Add(cueArray);
			list.Add(nodeArray);
			list.Add(effectArray);
			list.Add(soundArray);
			return list;
		}

		public static string[] getDirectoryFolderNames (string directory)
		{
			ArrayList fileslist = new ArrayList();
			try
			{
				DirectoryInfo dir = new DirectoryInfo (directory);
				foreach (var test in dir.GetDirectories()) 
				{
					if((test.Attributes & FileAttributes.Hidden) != FileAttributes.Hidden && !(test.Name.Contains("~"))){
						fileslist.Add(test.Name);
					}
				}
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			string[] files = (string[])fileslist.ToArray(typeof(string));
			return files;
		}

		public static string[] getSoundNames (string name)
		{
			ArrayList fileslist = new ArrayList();
			try
			{
				DirectoryInfo dir = new DirectoryInfo ("productions/" + name + "/sounds");
				foreach (var test in dir.GetFiles()) 
				{
					if((test.Attributes & FileAttributes.Hidden) != FileAttributes.Hidden && !(test.Name.Contains("~"))){
						fileslist.Add(test.Name);
					}
				}
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			string[] files = (string[])fileslist.ToArray(typeof(string));
			return files;
		}

		public static bool deleteSound(string name)
		{
			try
			{
				File.Delete("sounds/" + name);
				return true;
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			return false;
		}

		public static bool checkPassFile(string name, string pass){
			try
			{
				using (StreamReader sr = new StreamReader("text/pw"))
                {
					string cpass = sr.ReadLine();
					if(name == "User")
					{
						if(pass == cpass)
							return true;
						else
							return false;
					}
					else if(name == "Admin"){
						cpass = sr.ReadLine();
						if(pass == cpass)
							return true;
						else
							return false;
					}  
                    sr.Close();
                }
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			return false;
		}

		public static bool checkPass(string user, string pass){
			try
			{
				using (StreamReader sr = new StreamReader("text/pw"))
                {
					string[] newwords = new string[2];
					string cpass = sr.ReadLine();
					if(user == "User")
					{
						newwords[0] = pass;
						newwords[1] = sr.ReadLine();;
					}
					else if(user == "Admin"){
						newwords[0] = cpass;
						newwords[1] = pass;
					}
                    sr.Close();
					File.WriteAllLines("text/pw", newwords);
                }
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			return false;
		}

		public static void createProduction (string pass, string name)
		{
			bool exists = true;
			string path = "productions/" + name;
			int count = 1;
			try{
				while (exists) {
					if(!(exists = Directory.Exists(path)))
					{
						Directory.CreateDirectory(path);
						Directory.CreateDirectory(path + "/sounds");
						if(count > 1)
							name += count - 1;
						File.WriteAllText(path + "/" + name, pass);
					}
					else
					{
						path = "productions/" + name + count;
						count++;
					}
				}
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static string deleteProduction (string name, bool first)
		{
			String line = "error";
			try
            {
                using (StreamReader sr = new StreamReader("productions/" + name + "/" + name))
                {
                    line = sr.ReadLine();
					sr.Close();
				}
				if(line == "" || first == false)
					Directory.Delete("productions/" + name, true);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			return line;
		}

		public static string checkProdPass (string name)
		{
			string pass = "";
			try
            {
				string line = "";
                using (StreamReader sr = new StreamReader("productions/" + name + "/" + name))
                {
                    line = sr.ReadLine();
					sr.Close();
				}
				if(line != "")
					pass = line;
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			return pass;
		}

		public static void saveAddCue (string name, string sound, string prodName)
		{
			try
            {
				string text = "";
				string line = "";
				using (StreamReader sr = new StreamReader("productions/" + prodName + "/" + prodName))
                {
                    line = sr.ReadLine();
					if((line = sr.ReadLine()) != null)
						text = "\n\n" + name + "\n" + sound;
					else 
						text = "\n" + name + "\n" + sound;
					sr.Close();
				}
				while(text.LastIndexOf("\n") == text.Length - 1)
						text = text.Substring(0, text.LastIndexOf("\n"));
				File.AppendAllText("productions/" + prodName + "/" + prodName, text);
			}
			catch (Exception e)
			{
                WriteLog(e);
            }
		}

		public static void saveCueEdits (string name, string sound, string prodName, string oldname)
		{
			string newtext = "";
			try
            {
                using (StreamReader sr = new StreamReader("productions/" + prodName + "/" + prodName))
                {
					string line = "";
					while((line = sr.ReadLine()) != oldname)
						newtext += line + "\n";
					newtext += name + "\n";
					sr.ReadLine();
					newtext += sound + "\n";
					while((line = sr.ReadLine()) != null)
						newtext += line + "\n";
					sr.Close();
				}
				while(newtext.LastIndexOf("\n") == newtext.Length - 1)
					newtext = newtext.Substring(0, newtext.LastIndexOf("\n"));
				File.WriteAllText("productions/" + prodName + "/" + prodName, newtext);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static void saveAddNode (string name, string prodName, string cueName)
		{
			string newtext = "";
			try
            {
                using (StreamReader sr = new StreamReader("productions/" + prodName + "/" + prodName))
                {
					string line = sr.ReadLine();
					newtext += line + "\n";
					while((line = sr.ReadLine()) != null){
						if(line != cueName)
							newtext += line + "\n";
						else{
							string temp = sr.ReadLine();
							if(temp.IndexOf(".") > -1){
								newtext += line + "\n";
								newtext += temp + "\n";
								line = sr.ReadLine();
								while(line != "" && line != null){
									newtext += line + "\n";
									line = sr.ReadLine();
								}
								newtext += name + "\n50.0\n0\n0\n0.0\n0\n\n";
							}
							else{
								newtext += line + "\n";
								newtext += temp + "\n";
							}
						}
					}
					while(newtext.LastIndexOf("\n") == newtext.Length - 1)
						newtext = newtext.Substring(0, newtext.LastIndexOf("\n"));
					sr.Close();
				}
				File.WriteAllText("productions/" + prodName + "/" + prodName, newtext);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static void saveDeleteCue (string name, string prodName)
		{
			string newtext = "";
			try
            {
                using (StreamReader sr = new StreamReader("productions/" + prodName + "/" + prodName))
                {
					string line = sr.ReadLine();
					newtext += line + "\n";
					while((line = sr.ReadLine()) != null){
						if(line != name)
							newtext += line + "\n";
						else{
							string temp = sr.ReadLine();
							if(temp.IndexOf(".") > -1){
								while(line != "" && line != null){line = sr.ReadLine();}
							}
							else{
								newtext += line + "\n";
								newtext += temp + "\n";
							}
						}
					}
					while(newtext.LastIndexOf("\n") == newtext.Length - 1){
						if(newtext.LastIndexOf("\n") > -1)
							newtext = newtext.Substring(0, newtext.LastIndexOf("\n"));
						else
							break;
					}
					sr.Close();
				}
				File.WriteAllText("productions/" + prodName + "/" + prodName, newtext);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static void saveDeleteNode (string nodeName, string cueName, string prodName)
		{
			string newtext = "";
			try
            {
                using (StreamReader sr = new StreamReader("productions/" + prodName + "/" + prodName))
                {
					string line = sr.ReadLine();
					newtext += line + "\n";
					while((line = sr.ReadLine()) != null){
						if(line != cueName)
							newtext += line + "\n";
						else{
							string temp = sr.ReadLine();
							if(temp.IndexOf(".") > -1){
								newtext += line + "\n";
								newtext += temp + "\n";
								while((line = sr.ReadLine()) != nodeName){
									newtext += line + "\n";
								}
								for(int i = 0; i < 5; i++)
									line = sr.ReadLine();
							}
							else{
								newtext += line + "\n";
								newtext += temp + "\n";
							}
						}
					}
					while(newtext.LastIndexOf("\n") == newtext.Length - 1)
						newtext = newtext.Substring(0, newtext.LastIndexOf("\n"));
					sr.Close();
				}
				File.WriteAllText("productions/" + prodName + "/" + prodName, newtext);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static bool checkSound (string sound, string prodName)
		{
			try
			{
				return File.Exists("productions/" + prodName + "/sounds/" + sound);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
			return false;
		}

		public static void saveNodeEffects (string nodeName, string volume, string fadein, string fadeout, string pitch, string delay, string prodName, string cueName)
		{
			try
			{
				string temp = "";
				using (StreamReader sr = new StreamReader("productions/" + prodName + "/" + prodName))
                {
					temp = sr.ReadLine() + "\n";
					string line = "";
					while((line = sr.ReadLine()) != null){
						if(line != cueName)
							temp += line + "\n";
						else{
							temp += line + "\n";
							temp += sr.ReadLine() + "\n";
							line = sr.ReadLine();
							while(line != "" && line != null){
								if(line == nodeName){
									temp += line + "\n";
									temp += volume + "\n";
									temp += fadein + "\n";
									temp += fadeout + "\n";
									temp += pitch + "\n";
									temp += delay;
									for(int i = 0; i < 5; i++)
										line = sr.ReadLine();
									line = sr.ReadLine();
									if(line == "")
										temp += "\n\n";
									else if(line != null)
										temp += "\n";
								}
								else{
									temp += line + "\n";
									temp += sr.ReadLine() + "\n";
									temp += sr.ReadLine() + "\n";
									temp += sr.ReadLine() + "\n";
									temp += sr.ReadLine() + "\n";
									temp += sr.ReadLine() + "\n";
									line = sr.ReadLine();
									if(line == "")
										temp += "\n";
								}
							}
						}
					}
					while(temp.LastIndexOf("\n") == temp.Length - 1)
						temp = temp.Substring(0, temp.LastIndexOf("\n"));
					sr.Close();
				}
				File.WriteAllText("productions/" + prodName + "/" + prodName, temp);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
		}

		public static void saveMoveCueUporDown (string bottomCueName, string topCueName, string prodName)
		{
			
			try
			{
				string temp = "";
				using (StreamReader sr = new StreamReader("productions/" + prodName + "/" + prodName))
                {
					temp = sr.ReadLine() + "\n";
					string line = "";
					string bottom = "";
					while((line = sr.ReadLine()) != null){
						if(line == topCueName){
							bottom += line + "\n";
							line = sr.ReadLine();
							while(line != "" && line != null){
								bottom += line + "\n";
								line = sr.ReadLine();
							}
						}
						else if(line == bottomCueName){
							temp += line + "\n";
							line = sr.ReadLine();
							while(line != "" && line != null){
								temp += line + "\n";
								line = sr.ReadLine();
							}
							temp += line + "\n";
							temp += bottom;
							temp += line + "\n";
						}
						else
							temp += line + "\n";
					}
					while(temp.LastIndexOf("\n") == temp.Length - 1)
						temp = temp.Substring(0, temp.LastIndexOf("\n"));
					sr.Close();
				}
				File.WriteAllText("productions/" + prodName + "/" + prodName, temp);
			}
			catch (Exception e)
            {
                WriteLog(e);
            }
		}
	}
}

using System;
using System.Web;
using System.Web.UI;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Net;

namespace Network
{
	public partial class Default : System.Web.UI.Page
	{
		protected void Page_Load (object sender, EventArgs e)
		{
			if (Request.UrlReferrer == null) {
				string hostname = getUserIP ();
				string[] trustedArray = FileMethods.getTrusted ();
				foreach (string comp in trustedArray) {
					if (comp == hostname){
						Session ["UserType"] = "User";
						Response.Redirect ("ControllerPage.aspx");
					}
				}
			}
		}

		[WebMethod]
		public static bool checkPassword (string values)
		{
			int index = values.IndexOf(" ");
			string name = values.Substring(0, index);
			string pass = values.Substring(index + 1);
			if(FileMethods.checkPassFile(name, pass))
				return true;
			return false;
		}

		[WebMethod(EnableSession = true)]
		public static void sessionAdmin ()
		{
			Page temp = new Default();
			temp.Session["UserType"] = "Admin";
		}

		[WebMethod(EnableSession = true)]
		public static void sessionUser ()
		{
			Page temp = new Default();
			temp.Session["UserType"] = "User";
		}

		//Takes the IP from the asp page and resolves a hostname from DNS and passes it back
		[WebMethod]
		public static string getUserIP()
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
	}
}


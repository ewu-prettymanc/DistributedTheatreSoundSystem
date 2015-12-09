
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;

namespace Network
{
	public partial class UploadFiles : System.Web.UI.Page
	{

		protected void Submit1_ServerClick(object sender, EventArgs e)
	    {
	        if ((File1.PostedFile != null) && (File1.PostedFile.ContentLength > 0))
	        {
	            try
	            {
					string prodName = (string)Session["ProdName"];
		            string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
					bool exists = true;
					string path = "productions/" + prodName + "/sounds" + "/" + fn;
					int count = 1;
					while (exists) {
						if(!(exists = File.Exists(path)))
						{
							if(count > 1)
								fn = fn.Substring(0, fn.LastIndexOf(".")) + (count - 1) + fn.Substring(fn.LastIndexOf("."), fn.Length - fn.LastIndexOf("."));
							string saveLocation = Server.MapPath("productions/" + prodName + "/sounds") + "/" + fn;
	                		File1.PostedFile.SaveAs(saveLocation);
						}
						else
						{
							path = "productions/" + prodName + "/sounds" + "/" + fn.Substring(0, fn.LastIndexOf(".")) + count + fn.Substring(fn.LastIndexOf("."), fn.Length - fn.LastIndexOf("."));
							count++;
						}
					}
	            }
	            catch (Exception ex)
	            {
					try
					{
						System.IO.File.AppendAllText("text/log", "\n\n" + ex.ToString());

					}
					catch (Exception){}
	            }
	        }
	        else
	        {
	            
	        }
	    }
	}
}


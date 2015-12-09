<%@ Page Language="C#" Inherits="Network.UploadFiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head runat="server">
	<title>UploadFiles</title>

<style type="text/css">
.button{
  color: white;
  background-color:#1E1E1E;
  border-radius: 5px;
}


</style>

</head>
<body >
	 <form id="Form1" method="post" enctype="multipart/form-data" runat="server">
	  
		<input type=file class="button" id=File1 name=File1 accept="audio/*" runat="server" required/>
		<input type="submit" class="button" id="Submit1" value="Upload" runat="server" onserverclick="Submit1_ServerClick" onclick="parent.uploadSoundClick()"/>
       
	</form>
</body>
</html>

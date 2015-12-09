<%@ Page Language="C#" CodeFile="Default.aspx.cs" AutoEventWireUp="true" Inherits="Network.Default"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">


<html lang="en">
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/> 
        <meta charset="utf-8"/>
        <title>Distributed Theatre Sound System</title>
        <meta name="generator" content="Bootply" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
        <link href="Content/bootstrap.min.css" rel="stylesheet"/>
        
        <!--[if lt IE 9]>
          <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- CSS code from Bootply.com editor -->
        
        <style type="text/css">
            html,body {
  height: 100%;
}

/* wrapper for page content to push down footer */
.page-container {
  min-height: 100%;
  height: auto !important;
  height: 100%;
  /* negative indent footer by its height */
  margin: 0 auto -75px;
  /* pad bottom by footer height */
  padding: 0 0 120px;
}

body {
  background: #1E1E1E;
  color: #f9f9f9;
}

.center { 
	margin-left: 35%;
	color: black;
	margin-top: 15%;
	position: absolute;
	top: 0, left: 0, bottom: 0, right: 0;
	width: 30%;
	min-height: 23%;
	height: auto !important;
	height: 25%;
	background-color: gray;
	text-align: center;
	border-radius: 5px;
}

.button{
  color: white;
  background-color:#1E1E1E;
  border-radius: 5px;
}

.text{
	font-size: 2.5em;
}
        </style>
    </head>
    
    <!-- HTML code from Bootply.com editor -->
    
<body>
        
  <div class="page-container">
 	<div id="center-container" class='center'>
 		<p class="text">Login</p>
 		<select id="selLogin" class="button">
 			<option value="User">User</option>
 			<option value="Admin">Admin</option>
 		</select>
 		<div>
 			<br/>
 			<label>Password: </label>
 			<input class="button" id="txtPass" type="password" onkeypress="if(event.keyCode == 13){checkPassword();return false;}" style="width:30%"/>
 		</div>
 		<br/>
 		<input type="button" class="button" id="btnSubmit" value="Submit" onclick="checkPassword()"/>
 		<p/>
 	</div>
  </div><!--/.page-container-->
      
      	<script src="Scripts/jquery-1.10.2.min.js"></script>  
        <script type='text/javascript' src="Scripts/jquery.min.js"></script>
        <script type='text/javascript' src="Scripts/bootstrap.min.js"></script>
        
        <!-- JavaScript jQuery code from Bootply.com editor  -->
        
        <script type='text/javascript'>
        
        $(document).ready(function() {
		  $('[data-toggle=offcanvas]').click(function() {
		    $('.row-offcanvas').toggleClass('active');
		  });
        });
        
        </script>
        
        <script>
          (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
          (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
          m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
          })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
          ga('create', 'UA-40413119-1', 'bootply.com');
          ga('send', 'pageview');
        </script>
        
        <script>
        	
        	function checkPassword(){
        		if(txtPass.value.length > 5){
	        		var dataValue = "{values: '" + selLogin.value + " " + txtPass.value + "'}";
	        		$.ajax({
						type: "POST",
						url: "Default.aspx/checkPassword",
						data: dataValue,
						contentType: "application/json; charset=utf-8",
						success: function(check) {
							if(check.d){
								if(selLogin.value == "User"){
									$.ajax({
										type: "POST",
										url: "Default.aspx/sessionUser",
										contentType: "application/json; charset=utf-8",
									});
									setTimeout(function (){
										window.location.assign("ControllerPage.aspx");
									}, 500);
								}
								else if(selLogin.value == "Admin"){
									
									$.ajax({
										type: "POST",
										url: "Default.aspx/sessionAdmin",
										contentType: "application/json; charset=utf-8",
									});
									setTimeout(function (){
										window.location.assign("ControllerPage.aspx");
									}, 500);
								}
							}
							else{
								txtPass.value = "";
								alert("Password is incorrect");
							}
						}
					});
				}
				else{
					alert("Password must be at least 6 characters and/or numbers");
				}
        	}
        </script>
    </body>
</html>
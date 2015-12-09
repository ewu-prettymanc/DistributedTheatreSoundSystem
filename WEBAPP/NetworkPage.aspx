<%@ Page Language="C#" CodeFile="NetworkPage.aspx.cs" AutoEventWireUp="true" Inherits="Network.NetworkPage" %>




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
  width: 98%;
}

.button{
  color: white;
  background-color:#1E1E1E;
  border-radius: 5px;
}

body {
  padding-top: 51px; 
  background: #1E1E1E;
  color: #f9f9f9;
}
a {
  color:#efefef;
}
.text-center {
  padding-top: 20px;
}

.main-area {
  	color:gray;
  	width: 50%;
  	margin-left: 30%;
}

.inside-area {
	margin-top: 10px;
	background-color:gray;
	color: black;
	border-radius: 5px;
}

.forgetnode{
	text-align: center;
	padding-top: 3px;
}

.text{
	font-size: 1.5em;
}
        </style>
    </head>
    
    <!-- HTML code from Bootply.com editor -->
    
<body onload="pageLoad()">
    
  <div class="page-container" id="divTest">
   
	<!-- top navbar -->
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
       <div class="container-fluid">
    	<div class="navbar-header">
           <button type="button" class="navbar-toggle" data-toggle="offcanvas" data-target=".sidebar-nav">
             <span class="icon-bar"></span>
           </button>
           <a class="navbar-brand" onclick="changePage()" href="ControllerPage.aspx">Controller Page</a>
           </div>
       </div>
    </div>
      
    <div class="container-lg">
      	<div class="row row-offcanvas row-offcanvas-left">
       		 <br /><br />
			 <div class="col-xs-6 col-sm-3 full sidebar" align="center"><!--start of full sidebar-->
			      <!-- buttons  -->
				 <div class="sidebar-buttons" id="sidebarLoadProduction" role="navigation">
				 	<br /><br />
			  		<button type="button" class="button" id="btnNodeConfig">Node Configuration</button>
			  		<br /><br />
			  		<button class="button" id="btnTrustedComp" onclick="click_TrustedComp"  >Trusted Computers</button>
			  		<br /><br />
			  		<button class="button" id="btnChangePass" onclick="click_ChangePass">Change Password</button>
				 </div><!-- end of sidebar-buttons-->
		      </div><!--end of full sidebar-->
		      
	         <div class="main-area" id="MainArea" align="center">
        		<p id="pTitle" class="text"><strong>Node Configuration</strong></p>
        		<br />
        		<div class="inside-area" id="InsideArea" style="padding-bottom: 10px; max-height: 240px; overflow-y:auto;"></div>
        		<div id="UnderArea"/>
	       	 </div>
    	</div><!--/.row-->
  	</div><!--/.container-->
  </div><!--/.page-container-->
  
    	<script src="Scripts/json2.js"></script>   
        <script src="Scripts/jquery-1.10.2.min.js"></script>
        
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
      
        <script><!--Script for button event handlers-->
        	var mainTitle = document.getElementById('pTitle');
        	var check = "node";
        	var firstrun = true;
        	var myInterval;
        	
			btnNodeConfig.onclick = function() {
				if(check !=  "node"){
					while (InsideArea.hasChildNodes()) {
					    InsideArea.removeChild(InsideArea.lastChild);
					}
					if(check == "trust"){
						MainArea.removeChild(MainArea.lastChild);
					}
					btnNodeConfig.style.display = 'none';
					btnTrustedComp.style.display = 'none';
					btnChangePass.style.display = 'none';
					InsideArea.style.display = 'none';
					btnNodeConfig.style.background = 'green';
					btnTrustedComp.style.background = 'black';
					btnChangePass.style.background = 'black';
					mainTitle.innerHTML = "<b>Loading Data...</b>";
					check = "node";
					loadArrays();
				}
			}
			btnTrustedComp.onclick = function() {
				if(check !=  "trust"){
					clearInterval(myInterval);
					firstrun = true;
					while (InsideArea.hasChildNodes()) {
					    InsideArea.removeChild(InsideArea.lastChild);
					}
					btnNodeConfig.style.background = 'black';
					btnTrustedComp.style.background = 'green';
					btnChangePass.style.background = 'black';
					mainTitle.innerHTML = "<b>Trusted Computers</b>";
					check = "trust";
					loadTrusted();
				}
			}
			btnChangePass.onclick = function() { 
				clearInterval(myInterval);
				firstrun = true;
				while (InsideArea.hasChildNodes()) {
					    InsideArea.removeChild(InsideArea.lastChild);
				}
				if(check == "trust"){
					MainArea.removeChild(MainArea.lastChild);
				}
				btnNodeConfig.style.background = 'black';
				btnTrustedComp.style.background = 'black';
				btnChangePass.style.background = 'green';
				mainTitle.innerHTML = "<b>Change Password</b>";
				check = "pass";
				loadChangePass();
			}
			
			function changePage(){
				$.ajax({
					type: "POST",
					url: "NetworkPage.aspx/killBroadcaster",
					contentType: "application/json; charset=utf-8",
				});
			}
			
			function pageLoad() { 
				btnNodeConfig.style.display = 'none';
				btnTrustedComp.style.display = 'none';
				btnChangePass.style.display = 'none';
				InsideArea.style.display = 'none';
				btnNodeConfig.style.background = 'green';
				mainTitle.innerHTML = "<b>Loading Data...</b>";
				loadArrays();
			}
			
			function loadArrays(){
				$.ajax({
					type: "POST",
					url: "NetworkPage.aspx/makeArrays",
					contentType: "application/json; charset=utf-8",
					success: function(){
						$.ajax({
							type: "POST",
							url: "NetworkPage.aspx/getNodeNames",
							contentType: "application/json; charset=utf-8",
							success: function(nodeNames){
								$.ajax({
									type: "POST",
									url: "NetworkPage.aspx/getNodeMacs",
									contentType: "application/json; charset=utf-8",
									success: function(nodeMacs){
										$.ajax({
											type: "POST",
											url: "NetworkPage.aspx/getNodeIPs",
											contentType: "application/json; charset=utf-8",
											success: function(nodeIPs){
												$.ajax({
													type: "POST",
													url: "NetworkPage.aspx/getNodeActive",
													contentType: "application/json; charset=utf-8",
													success: function(nodeActive){
														loadNodeArea(nodeNames.d, nodeMacs.d, nodeIPs.d, nodeActive.d);
													}
												});
											}
										});
									}
								});
							}
						});
					}
				});
			}
			
			function loadNodeArea(nodeNames, nodeMacs, nodeIPs, nodeActive){
				btnNodeConfig.style.display = 'block';
				btnTrustedComp.style.display = 'block';
				btnChangePass.style.display = 'block';
				InsideArea.style.display = 'block';
				mainTitle.innerHTML = "<b>Node Configuration</b>";
				var tbl = document.createElement('table');
				tbl.style.width = '80%';
				tbl.setAttribute('border','1');
				
				var header = tbl.createTHead();
				var row = header.insertRow(0);
				var cell0 = row.insertCell(0);
				cell0.innerHTML = "<b>Active</b>";
				var cell1 = row.insertCell(1);
				cell1.innerHTML = "<b>Name</b>";
				var cell2 = row.insertCell(2);
				cell2.innerHTML = "<b>MAC Address</b>";
				var cell3 = row.insertCell(3);
				cell3.innerHTML = "<b>IP Address</b>";
				var cell4 = row.insertCell(4);
				cell4.innerHTML = "<b>Options</b>";
				<!--Dynamicaly updates if there is a change in the nodes-->
				if(firstrun){
					myInterval = setInterval(function(){
						firstrun = false;
						while(InsideArea.firstChild)
						{InsideArea.removeChild(InsideArea.firstChild);}
						loadArrays();
					}, 5000);
				}
        		
        		var count = 1;
				for (var i in nodeNames) {
					var row = tbl.insertRow(count);
					var cell0 = row.insertCell(0);
					var cell1 = row.insertCell(1);
					var cell2 = row.insertCell(2);
					var cell3 = row.insertCell(3);
					var cell4 = row.insertCell(4);
					row.cells[4].className = "forgetnode";
					cell1.innerHTML = nodeNames[i];
					cell2.innerHTML = nodeMacs[i];
					cell3.innerHTML = nodeIPs[i];
					var activeImage = document.createElement("IMG");
					
					if(nodeActive[i]){
						activeImage.src = "images/green.png";
						var OptionListBox = document.createElement("select");
						var option1 = document.createElement("option");
					    option1.text = "Locate Node";
					    option1.value = "Locate Node";
					    option1.onclick = function() {
					    	var row1 = this.parentNode.parentNode.parentNode;
					    	var dataValue = "{ip: '" + row1.cells[3].innerHTML + "'}"; 
					    	$.ajax({
					            type: "POST",
					            url: "NetworkPage.aspx/testNode",
								data: dataValue,
								contentType: "application/json; charset=utf-8",
							});
					    }
					    OptionListBox.add(option1, null);
					    var option2 = document.createElement("option");
					    option2.text = "Reboot Node";
					    option2.value = "Reboot Node";
					    option2.onclick = function() {
					    	var row1 = this.parentNode.parentNode.parentNode;
					    	var dataValue = "{ip: '" + row1.cells[3].innerHTML + "'}"; 
					    	$.ajax({
					            type: "POST",
					            url: "NetworkPage.aspx/rebootNode",
								data: dataValue,
								contentType: "application/json; charset=utf-8",
					        });
					    }
					    OptionListBox.add(option2, null);
					    var option3 = document.createElement("option");
					    option3.text = "Rename Node";
					    option3.value = "Rename Node";
					    option3.onclick = function() {
					    	while(UnderArea.hasChildNodes()){
								UnderArea.removeChild(UnderArea.firstChild);
							}
					    	var row1 = this.parentNode.parentNode.parentNode;
					    	var p = document.createElement("p");
					    	UnderArea.appendChild(p);
					    	var div = document.createElement("div");
					    	var changetext = document.createElement("LABEL");
							changetext.innerHTML = "Enter a new name for " + row1.cells[1].innerHTML + ":";
							var changeName = document.createElement("INPUT");
							changeName.setAttribute("type", "text");
							changeName.width = "20px";
							changeName.className = "button";
							div.appendChild(changetext);
							div.appendChild(changeName);
							UnderArea.appendChild(div);
							var submit = document.createElement("BUTTON");
							submit.className = "button";
							var textNode = document.createTextNode("Submit");
							submit.appendChild(textNode);
							submit.onclick = function(){
					    		var dataValue = "{ip: '" + row1.cells[3].innerHTML + "', newName: '" + changeName.value + "', oldName: '" + row1.cells[1].innerHTML + "'}"; 
					    		$.ajax({
						            type: "POST",
						            url: "NetworkPage.aspx/renameNode",
									data: dataValue,
									contentType: "application/json; charset=utf-8",
									success: function () {
										while(UnderArea.hasChildNodes()){
											UnderArea.removeChild(UnderArea.firstChild);
										}
									}
						        });
					    	}
					    	UnderArea.appendChild(submit);
					    	var cancelRename = document.createElement("BUTTON");
					    	cancelRename.className = "button";
					    	var textRename = document.createTextNode("Cancel");
							cancelRename.appendChild(textRename);
							cancelRename.onclick = function(){
								while(UnderArea.hasChildNodes()){
									UnderArea.removeChild(UnderArea.firstChild);
								}
							}
							UnderArea.appendChild(cancelRename);
					    }
					    OptionListBox.add(option3, null);
					    row.cells[4].appendChild(OptionListBox);
					}
					else{
						activeImage.src = "images/red.png";
						delNodeButton(row, tbl);
					}
					row.cells[0].appendChild(activeImage);
				    count++;
				}
        		
        		var space = document.createElement("p");
        		InsideArea.appendChild(space);
				InsideArea.appendChild(tbl);
			}
			
			function delNodeButton(row, tbl){
				var forgetNode = document.createElement("BUTTON");
				var text = document.createTextNode("X");
				forgetNode.appendChild(text);
				forgetNode.style.backgroundColor='Red';
				forgetNode.onclick = function() {<!--click button to "forget" Node-->
					var selectedCell = this.parentNode;					
					var selectedRow = selectedCell.parentNode;
					var dataValue = "{mac: '" + selectedRow.cells[2].innerHTML + "'}";
					var index = this.parentNode.parentNode.rowIndex;
					tbl.deleteRow(index);
					<!--  to call a method from another class-->
					$.ajax({
			            type: "POST",
			            url: "NetworkPage.aspx/deleteNode",
						data: dataValue,
						contentType: "application/json; charset=utf-8",
			        });
				}
				row.cells[4].appendChild(forgetNode);
			}
			
			function loadTrusted() {
				var tbl=document.createElement('table');
				tbl.style.width = '50%';
				tbl.setAttribute('border','1');
				
				var header = tbl.createTHead();
				var row = header.insertRow(0);
				var cell0 = row.insertCell(0);
				cell0.innerHTML = "<b>Computer Name</b>";
				var cell1 = row.insertCell(1);
				cell1.innerHTML = "<b>Delete</b>";
				cell1.className = "forgetnode";
				$.ajax({
					type: "POST",
					url: "NetworkPage.aspx/getTrusted",
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: function (array) {
						var temp = array.d;
						var count = 1;
						for(var item in temp){
							var row = tbl.insertRow(count);
							var cell2 = row.insertCell(0);
							cell2.innerHTML = temp[item];
							var cell3 = row.insertCell(1);
							cell3.className = "forgetnode";
							var deleteTrusted = document.createElement("BUTTON");
							var text = document.createTextNode("X");
							deleteTrusted.appendChild(text);
							deleteTrusted.style.backgroundColor='Red';
							deleteTrusted.onclick = function() { <!--Click button event to delete a trusted computer-->
								var selectedCell = this.parentNode;
								var selectedRow = selectedCell.parentNode;
								var dataValue = "{name: '" + selectedRow.cells[0].innerHTML + "'}";
								var index = this.parentNode.parentNode.rowIndex;
								tbl.deleteRow(index);
								<!--  to call a method from another class-->
								$.ajax({
						            type: "POST",
						            url: "NetworkPage.aspx/deleteTrusted",
									data: dataValue,
									contentType: "application/json; charset=utf-8",
						        });
						        
							}
							row.cells[1].appendChild(deleteTrusted);
							count++;
						}
					}
				});
				var space = document.createElement("p");
        		InsideArea.appendChild(space);
				InsideArea.appendChild(tbl);
				
				var addComputerArea = document.createElement('div');
				addComputerArea.style.padding="30px";
				MainArea.appendChild(addComputerArea);
				var btnAddComputer = document.createElement('BUTTON');
				btnAddComputer.className = "button";
				var txtButton = document.createTextNode("Add");
				btnAddComputer.appendChild(txtButton);
				btnAddComputer.onclick = function() {
					$.ajax({
						type: "POST",
						url: "NetworkPage.aspx/getUserIP",
						contentType: "application/json; charset=utf-8",
						success: function (hostname) {
							var dataValue = "{hostname: '" + hostname.d + "'}";
							$.ajax({
					            type: "POST",
					            url: "NetworkPage.aspx/writeTrusted",
								data: dataValue,
								contentType: "application/json; charset=utf-8",
								success: function (message) {
									if(message.d.length > 0)
									{
										alert(message.d);
									}
									else
									{
										var row = tbl.insertRow(-1);
										var cell2 = row.insertCell(0);
										cell2.innerHTML = hostname.d;
										var cell3 = row.insertCell(1);
										cell3.className = "forgetnode";
										var deleteTrusted = document.createElement("BUTTON");
										var text = document.createTextNode("X");
										deleteTrusted.appendChild(text);
										deleteTrusted.style.backgroundColor='Red';
										row.cells[1].appendChild(deleteTrusted);
										deleteTrusted.onclick = function() { <!--Click button event to delete a trusted computer-->
											var selectedCell = this.parentNode;
											var selectedRow = selectedCell.parentNode;
											var dataValue = "{name: '" + selectedRow.cells[0].innerHTML + "'}";
											var index = this.parentNode.parentNode.rowIndex;
											tbl.deleteRow(index);
											//row.cells[1].appendChild(deleteTrusted);
											<!--  to call a method from another class-->
											$.ajax({
							            		type: "POST",
							            		url: "NetworkPage.aspx/deleteTrusted",
												data: dataValue,
												contentType: "application/json; charset=utf-8",
							        		});
										}
									}
								}
					        });
						}
					});
				}
				
				var txtAdd = document.createTextNode("Add this computer to Trusted List:             ");
				addComputerArea.appendChild(txtAdd);
				addComputerArea.appendChild(btnAddComputer);
			}
			
			function loadChangePass(){
				var space = document.createElement("p");
        		InsideArea.appendChild(space);
				var usertype = document.createElement("select");
				usertype.className = "button";
				var option1 = document.createElement("option");
				option1.value = "User";
				option1.text = "User";
				usertype.appendChild(option1);
				var option2 = document.createElement("option");
				option2.value = "Admin";
				option2.text = "Admin";
				usertype.appendChild(option2);
				InsideArea.appendChild(usertype);
				var p = document.createElement("p");
				InsideArea.appendChild(p);
				var divUpper = document.createElement("div");
				var text = document.createElement("LABEL");
				text.innerHTML = "Enter a new password:";
				var pass = document.createElement("INPUT");
				pass.setAttribute("type", "password");
				pass.width = "20px";
				pass.className = "button";
				divUpper.appendChild(text);
				divUpper.appendChild(pass);
				InsideArea.appendChild(divUpper);
				var divLower = document.createElement("div");
				var confirmtext = document.createElement("LABEL");
				confirmtext.innerHTML = "Confirm a new password:";
				var confirmpass = document.createElement("INPUT");
				confirmpass.setAttribute("type", "password");
				confirmpass.width = "20px";
				confirmpass.className = "button";
				divLower.appendChild(confirmtext);
				divLower.appendChild(confirmpass);
				InsideArea.appendChild(divLower);
				var submit = document.createElement("BUTTON");
				submit.className = "button";
				var textNode = document.createTextNode("Submit");
				submit.appendChild(textNode);
				submit.onclick = function(){
					while(this.parentNode.lastChild != this){
						this.parentNode.removeChild(this.parentNode.lastChild);
					}
					if(pass.value == confirmpass.value){
						if(pass.value.length > 5){
							var passcheck = passCheck(pass.value);
							if(usertype.value == "User" || (usertype.value == "Admin" && passcheck == "ok")){
								var dataValue = JSON.stringify({user: usertype.value, pass: pass.value});
								$.ajax({
									type: "POST",
									url: "NetworkPage.aspx/writePassword",
									data: dataValue,
									contentType: "application/json; charset=utf-8",
									success: function(check) {
										pass.value = "";
										confirmpass.value = "";
										var newDiv = document.createElement("div");
										var newText = document.createElement("LABEL");
										if(check){
											newText.innerHTML = "Success!";
											newText.style.color = "green";
										}
										else{
											newText.innerHTML = "Fail!";
											newText.style.color = "red";
										}
										newDiv.appendChild(newText);
										InsideArea.appendChild(newDiv);
									}
								});
							}
							else{
								pass.value = "";
								confirmpass.value = "";
								alert(passcheck);
							}
						}
						else{
							pass.value = "";
							confirmpass.value = "";
							alert("Password needs to be at least 6 characters");
						}
					}
					else{
						pass.value = "";
						confirmpass.value = "";
						alert("Passwords do not match");
					}
				}
				InsideArea.appendChild(submit);
			}
			
			function passCheck(pass){
				if (pass.search(/\d/) == -1) {
			        return("Password doesn't contain a number.");
			    } 
			    else if (pass.search(/[A-Z]/) == -1) {
			        return("Password doesn't contain a capital letter.");
			    }
			    else{
			    	return "ok";
			    }
			}
        </script>
    </body>
</html>




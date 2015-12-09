<%@ Page Language="C#" CodeFile="ControllerPage.aspx.cs" AutoEventWireUp="true" Inherits="Network.ControllerPage"%>



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
          <script src="Scripts/html5.js"></script>
        <![endif]-->

        <!-- CSS code from Bootply.com editor -->
        
<style type="text/css">
html,body {
  height: 100%;
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

.sidebar-productiondata{
  background-color:gray;
  color: #1E1E1E;
  padding-top: 10px;
  padding-left: 10px;
  padding-bottom: 10px;
  border-radius: 5px;  
}

.sidebar-spacer{
  background-color:#1E1E1E; 
}

.sidebar-active{
  background-color:gray;
  padding-top: 10px;
  padding-left: 10px;
  padding-bottom: 10px;
  border-radius: 5px; 
}

.mainarea-cuelist{
  background-color:gray;
  color: #1E1E1E;
  font-size: 18px;
  padding-right: 10px;
  padding-left: 10px;
  border-radius: 5px;
  border-style: solid;
  width: 100%;
}

.production {
	background-color:gray;
	color: #1E1E1E;
	padding-left: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
	padding-right: 10px;
	border-radius: 0px 0px 10px 10px;;
	border-style: solid;
	border-color: #1E1E1E;
	font-size: 22px;
}

.productionInner {
	background-color:gray;
	color: #1E1E1E;
	padding-left: 10px;
	padding-top: 10px;
	padding-bottom: 10px;
	padding-right: 10px;
	border-radius: 10px;;
	border-style: solid;
	border-color: #1E1E1E;
	font-size: 22px;
}
.productionSquare {
	background-color:#FFB84D;
	color: #1E1E1E;
	padding-left: 10px;
	padding-bottom: 10px;
	padding-top: 10px;
	padding-right: 10px;;
	border-style: solid;
	border-color: #1E1E1E;
	font-size: 22px;
}

.cuelist{
  color: #1E1E1E;
  font-weight: bold;
  padding-top: 10px;
  padding-right: 10px;
  padding-left: 20px;
  font-size: 16px;
}

.nodeTable {
	padding-bottom: 10px;
}

.nodelist{
  color: #1E1E1E;
  padding-right: 10px;
  padding-left: 30px;
  font-size: 14px;
}

.textbox {
	color: white;
	background-color:#1E1E1E;
	border-radius: 5px;
	font-size: 14px;
}

.button{
  color: white;
  background-color:#1E1E1E;
  border-radius: 5px;
}

.nodeButton{
	color: white;
	background-color:#1E1E1E;
	border-radius: 5px;
	font-size: 10pt;
	float: right;
}
.editButton{
	color: white;
	background-color:#1E1E1E;
	border-radius: 5px;
	font-size: 10pt;
}

.playbutton{
  padding-top: 10px;
  padding-bottom: 10px;
  text-align: center;
  float: right; 
}

.playCue {
  text-align: center;
}

.exitbutton{
  padding-top: 10px;
  padding-bottom: 10px;
  text-align: center;
  float: left;
}

.image{
	text-align: center;
	padding-top: 3px;
	color: black;
}

.activeCueTitle{
	padding-left: 3px;
	font-weight: bold;
  	color: black;
}

.activeCueTime{
  	text-align: center;
}

.bigButtons{
  overflow: hidden;
}

.warning {
  padding-bottom: 10px;
}
</style>
    </head>
    
    <!-- HTML code from Bootply.com editor -->
    
<body onLoad="pageLoad()">
        
  <div class="page-container">
  
	<!-- top navbar -->
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
       <div class="container-fluid">
    	<div class="navbar-header">
           <button type="button" class="navbar-toggle" data-toggle="offcanvas" data-target=".sidebar-nav">
             <span class="icon-bar"></span>   
           </button>
           <a id="navNetwork" class="navbar-brand" href="#" onclick="clickNetwork()"></a>
    	</div>
       </div>
    </div>
    <div class="container" id = "mainContainer" style="display:none">
      	<div class="row row-offcanvas row-offcanvas-left"> 
	 	<br /><br />
	 
		<div class="col-xs-6 col-sm-3 full sidebar"><!--start of full sidebar-->	
	
		      <!-- Load/Create/Delete Production button area  -->	      
	         <div class="sidebar-lcdproduction" id="sidebarlcdproduction" role="navigation">
	         	<br /><br />
	        	<button class="button" id="button_CreateProduction" style="width:50%">Create Production</button>
	            <br /><br />
	            <button class="button" id="button_LoadProduction" style="width:50%">Load Production</button>
	            <br /><br />
	            <button class="button" id="button_DeleteProduction" style="width:50%">Delete Production</button>
	         </div> 
		         
			 <div id="sliderArea">
				<div id="slider"></div>
				<br />        
	         </div>     
		     
		     <!-- Big Buttons  -->
	    	 <div id="playButtonDiv" class = "bigButtons">
				<input type="image" class="exitbutton" id="bigExitButton" src="images/close.png"/>
	    		<input type="image" class="playbutton" id="bigPlayButton" src="images/playNext.png"/>
	    	 </div> 
	                  
	         <!-- Load Production Dropdown  -->                      
	         <div class="button" id="dropDown">
	            <h2 id="dropdownText"style="font-size: 16px"></h2>
	            <select class="button" id="dropDownMenu" style="width:50%"></select>
	         </div> 
	                
	         <!-- Cancel Button  -->
	         <div id="divbutton_Cancel">
	             <div class="button">
	                <p></p>
	                <button class="button" id="button_Cancel" style="width:50%">Cancel</button> 		            
	             </div>  		
	         </div> 
	         <br /> 

	         <!-- Active Cue -->    
	         <div class="sidebar-active" id="sidebaractive" role="navigation">
	          	<div id="activeAreaTitle"></div>                                                                                       
	            <div class="production-data" id="activeArea" style="max-height: 182px; overflow-y:auto;"></div>
	            <p></p>
	            <div id="activeAreaFooter" align="center"></div>    
	         </div>    
        </div><!--end of full sidebar-->
        
        
        
		<!-- main area .col-xs-12-->
        <div class="col-xs-12 col-sm-9" data-spy="scroll" data-target="#sidebar-nav" id="main">
        	<div class="productionInner" id="cueArea" style="max-height: 400px; overflow-y:auto;"> </div>
        </div>
        
        <!--createproduction area-->
        <div id="createProd" class="col-xs-10 col-sm-7" style="width:40%">
        	<div id="createProdInner" class="productionInner" align="center"/>
        </div>
        
      </div><!--/.row-->
  	</div><!--/.container-->
  </div><!--/.page-container-->
        
    <script type="text/javascript" src="Scripts/jquery-1.3.2.min.js"></script>
    <script type='text/javascript' src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/json2.js"></script>
    <script src="Scripts/productions.js"></script>
    <script type='text/javascript' src="Scripts/jquery-1.9.1.min.js"></script>
	<script src="Scripts/jquery-ui.js"></script>
	<link rel="stylesheet" href="Scripts/jquery-ui.css">
	
        
    <!-- JavaScript jQuery code from Bootply.com editor  -->
    <script type='text/javascript'>       
	    $(document).ready(function() {           
			$('[data-toggle=offcanvas]').click(function() {
			$('.row-offcanvas').toggleClass('active');
			});        
	    });       
    </script>
        
	<script type="text/javascript">
		jQuery(document).ready(function() {
		  jQuery(".content").hide();
		  //toggle the componenet with class msg_body
		  jQuery(".heading").click(function()
		  {
		    jQuery(this).next(".content").slideToggle(500);
		  });
		});
	</script>
	


    
	<script>
  		$("#slider").slider({
    		value  : 60,
    		step   : 2,
    		range  : 'min',
    		min    : 0,
    		max    : 100,
    		change : function(){
        		var value = $("#slider").slider("value");
        		var dataValue = "{level: '" + value + "'}";
				$.ajax({
					type: "POST",
					url: "ControllerPage.aspx/changeGlobalVolume",
					data: dataValue,
					contentType: "application/json; charset=utf-8",
				});
    		}
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
    	<!--Global Variables-->
        var slider = $('#slider');
        var cueElementArray = [];		<!--an array that holds cue "Elements" -->       
        var activeCueArray = [];		<!--an array that holds ACTIVE cue "Names" -->                
        var nextCue = 0;				<!--used to track the index of the next cue to be played -->
		var globalProduction;
		var editCueCheck = ""; 			<!--used to track which cue is importing sound-->
		var usertype;					<!--tracks if they are user or admin-->
		var myInterval; 				<!--interval for updated nodes dynamically-->
		var tbdy;
		var timerArray = new Array(); 	<!--timer array for active cue timers-->
		var syncInterval;				<!--interval for syncing files to other nodes-->
		var firstrun = true;
        
        <!--Methods -->
        function pageLoad()
        {
        	if(firstrun){
	        	var dataValue = "{level: '60'}";
				$.ajax({
					type: "POST",
					url: "ControllerPage.aspx/changeGlobalVolume",
					data: dataValue,
					contentType: "application/json; charset=utf-8",
				});
				firstrun = false;
			}
        	clearInterval(myInterval);
        	usertype = '<%=Session["UserType"] %>';
        	if(usertype == "User"){
        		button_CreateProduction.style.display = 'none';
        		button_DeleteProduction.style.display = 'none';
        		navNetwork.innerHTML = "Edit/Network";
        	}
        	else
        		navNetwork.innerHTML = "Network";
            mainContainer.style.display = 'block';
            sliderArea.style.display = 'none';
            sidebaractive.style.display = 'none';
            main.style.display = 'none';
            divbutton_Cancel.style.display = 'none';
            dropDownMenu.style.display = 'none';
            bigPlayButton.style.display = 'none';
            bigExitButton.style.display = 'none';
            sidebarlcdproduction.style.display = 'block';
            createProd.style.display = 'none';
            emptyDropDownList();
            
            tbdy = document.createElement("tbody");
            tbdy.id = "activeTbody"
            var tbl = document.createElement("table");
            tbl.id = "activeTable";
            activeArea.appendChild(tbl);
            tbl.appendChild(tbdy);
            while (createProdInner.firstChild)
        	{createProdInner.removeChild(createProdInner.firstChild);}
            while (activeArea.firstChild)
        	{activeArea.removeChild(activeArea.firstChild);}
            
            nextCue = 0;            
            cueElementArray = [];		<!--reset element array -->       
        	activeCueArray = [];		<!--reset active cue arra -->
        	
        	setTimeout(initialSync(), 30000);
        	setTimeout(periodicSync(), 60000);
        }
        
        function initialSync(){
        	$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/initialSync",
				contentType: "application/json; charset=utf-8",
			});
        }
        
        function periodicSync(){
        	syncInterval = setInterval(function(){
        		$.ajax({
					type: "POST",
					url: "ControllerPage.aspx/regularSync",
					contentType: "application/json; charset=utf-8",
				});
        	}, 30000);
        }

        function emptyDropDownList()
        {
            while (dropDownMenu.firstChild) 
            {
                dropDownMenu.removeChild(dropDownMenu.firstChild);    <!--empties dropdown menu -->
            }
        }
        
        function emptyProduction()
        {
        	while (cueArea.firstChild)
        	{
            	cueArea.removeChild(cueArea.firstChild);
            }
            nextCue = 0;
        }
        
        function updateProduction()		<!--Updates the colors of the cues -->
        {       	
        	for(var c in cueElementArray)
        	{
        		if(c == nextCue)		<!--nextCue will have green background -->
            	{
            		cueElementArray[c].style.background = '#71FF71';
            		cueElementArray[c].parentNode.parentNode.nextSibling.style.background = '#71FF71';
            		if(usertype == "Admin")
            			cueElementArray[c].parentNode.parentNode.nextSibling.nextSibling.style.background = '#71FF71';	
             	}
             	else if(c > nextCue)	<!--blue background -->
             	{
             		cueElementArray[c].style.background = '#66A3FF';
             		cueElementArray[c].parentNode.parentNode.nextSibling.style.background = '#66A3FF';
             		if(usertype == "Admin")
             			cueElementArray[c].parentNode.parentNode.nextSibling.nextSibling.style.background = '#66A3FF';
             	}
             	else{
	        		cueElementArray[c].className = "production";
	             	cueElementArray[c].style.background = 'gray';
	             	cueElementArray[c].parentNode.parentNode.nextSibling.style.background = 'gray';
	             	if(usertype == "Admin")
	             		cueElementArray[c].parentNode.parentNode.nextSibling.nextSibling.style.background = 'gray';
	            }
        	}
        	
        	for(var d in activeCueArray)	<!--if active, yellow background -->
        	{
        		if(activeCueArray[d] != cueElementArray[nextCue]){
	            	activeCueArray[d].style.background = '#FFFF66';
	            	activeCueArray[d].parentNode.parentNode.nextSibling.style.background = '#FFFF66';
	            	if(usertype == "Admin")
	            		activeCueArray[d].parentNode.parentNode.nextSibling.nextSibling.style.background = '#FFFF66';
	            }
        	}
        	
        	if(cueElementArray.length == 0)
        	{
        		bigPlayButton.style.display = "none";
        	}
        }
        
        function setStopButton(element, text)<!-- sets stop image for buttons -->
        {
            element.src = "images/delete.png";
            element.title = "Delete" + text;
        } 
        
        function setPlayButton(element, text)<!-- sets play image for buttons -->
        {
        	element.src = "images/play.png";
        	element.title = "Play" + text;
        }
        
        function setPauseButton(element, text)
        {
        	element.src = "images/pause.jpg";
        	element.title = "Pause" + text;
        }
        
        function setPlusButton(element, edit)		<!-- sets plus image for buttons -->
        {
        	element.src = "images/plus.png";
        	        	if(edit)
        	{ element.title = "Open Edit View";  }
        	else
        	{ element.title = "Open Node View"; }
        }
        
        function setMinusButton(element, edit)		<!-- sets minus image for buttons -->
        {
        	element.src = "images/minus.png";
        	if(edit)
        	{ element.title = "Close Edit View";  }
        	else
        	{ element.title = "Close Node View"; }
        }
        
        function setAddButton(element)		<!-- sets minus image for buttons -->
        {
        	element.src = "images/newadd.png";
        	element.title = "Add Cue Menu";
        }
        
        function setGearButton(element) <!-- sets minus image for buttons -->
		{
			element.src = "images/gear.png";
			element.title = "Edit Cue Menu";
		}
		function setUpButton(element) <!-- sets minus image for buttons -->
		{
			element.src = "images/up.png";
			element.title = "Move Cue Up";
		}
		function setDownButton(element) <!-- sets minus image for buttons -->
		{
			element.src = "images/down.png";
			element.title = "Move Cue Down";
		}
        
        function setGreenWarning(element, production)		<!-- sets minus image for buttons -->
        {
        	element.src = "images/green.png";
        	if(production)
        	{ element.title = "All Nodes/Sounds Present"; }
        	else
        	{ element.title = "Node Online"; }
        }
        
        function setRedWarning(element, production)		<!-- sets minus image for buttons -->
        {
        	element.src = "images/red.png";
        	if(production)
        	{ element.title = "Missing Node/Sound"; }
        	else
        	{ element.title = "Node Offline"; }
        }
        
        function populateActive(tbdy) 
        {
        	while (activeArea.firstChild)			<!-- resets the active cue -->
        	{activeArea.removeChild(activeArea.firstChild);}
        	
        	while (activeAreaTitle.firstChild)		<!-- resets the active cue Title -->
        	{activeAreaTitle.removeChild(activeAreaTitle.firstChild);}
        	
        	while (activeAreaFooter.firstChild)		<!-- resets the active cue Footer -->
        	{activeAreaFooter.removeChild(activeAreaFooter.firstChild);}
        	
	        var title = document.createElement("label");
	        var x = document.createTextNode("Active Cues: ");
	        title.appendChild(x);
	        title.style.color = "black";
	        title.style.fontWeight = "bold";
	       	activeAreaTitle.appendChild(title);
        	var tbl=document.createElement('table');
			
			<!--tbl.className = --> 
        	var activeImage1 = document.createElement("IMG");
        	var activeImage2 = document.createElement("IMG");
        	createActiveCueTable(tbdy);
        	tbl.style.borderColor = "#1E1E1E";                   
            tbl.style.borderStyle="solid";             	
            tbl.style.width = "95%";
			tbl.setAttribute('border','1');
            tbl.appendChild(tbdy);
            sidebaractive.style.display = "block";
            activeArea.appendChild(tbl);
            createPlayPauseDelTable(tbdy);
        }
        
        <!--Dynamically creates active Cue Table -->  
        function createActiveCueTable(tbdy){
       		for(var a in activeCueArray)        <!--iterates through activeCueArray -->
            {      
             	addActiveRow(activeCueArray[a],tbdy);
            }
        }
            
        <!--Creates play/pause/delete all Table -->
        function createPlayPauseDelTable(tbdy){    
            var tbl2=document.createElement('table');			<!--creates table -->		
            var tbdy2 = document.createElement('tbody');		<!--creates table body -->
            var tr2 = document.createElement('tr'); 			<!-- creates table row -->
            
            var td4 = document.createElement('td');				<!-- creates new td for play/pause all-->
            var s = document.createElement("input");
            setPauseButton(s, " all");
            s.type = "image";
            td4.appendChild(s);									<!-- adds child cell to td -->
            td4.className = "image";
            td4.id = 'pause';
            td4.onclick = function()	<!--add click event for pause/play all button-->
            {
            	var cues = new Array(); <!--Array that will hold all nodeArrays attached to each Cue in the active cue-->
				for(var j in activeCueArray){
					for (var i in globalProduction.cueArray){
						if(globalProduction.cueArray[i].name == activeCueArray[j].childNodes[1].innerHTML)
							cues.push(globalProduction.cueArray[i].nodeArray);
					}
				}
				if(this.id == "play")	<!-- if ALL id == play -->
				{
					var jstring = JSON.stringify({nodes: cues, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/sendResumeAll",
						data: jstring,
						contentType: "application/json; charset=utf-8",
					});
					setPauseButton(this.children[0], " all");	<!-- sets ALL image to pause -->
					this.id = "pause";							<!-- sets ALL id to pause -->
					
					for(var c in tbdy.children)	<!-- iterate through all rows in table -->
					{												
						var test1 = tbdy.children[c];
						var test2 = test1.children[2];
						var test3 = test2.children[0];
						setPauseButton(test3, "");<!-- changes all images to pause -->
						tbdy.children[c].children[2].id = "pause";<!-- changes all id to pause -->
						
						var time = tbdy.children[c].firstChild.nextSibling.innerHTML;
						pauseAllTR(test2, time, c);
					}
				}
				else					<!-- if ALL id == pause -->
				{
					var jstring = JSON.stringify({nodes: cues, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/sendPauseAll",
						data: jstring,
						contentType: "application/json; charset=utf-8",
					});
				
					setPlayButton(this.children[0], " all");	<!-- sets ALL image to play -->
					this.id = "play";							<!-- sets ALL id to pause -->
					
					for(var d in tbdy.children)	<!-- iterate through all rows in table -->
					{						
						var test1 = tbdy.children[d];
						var test2 = test1.children[2];
						var test3 = test2.children[0];
						setPlayButton(test3, "");<!-- changes all images to play -->
						tbdy.children[d].children[2].id = "play";<!-- changes all id to play -->
						clearInterval(timerArray[d]);
					}
				}
		    }
		    tr2.appendChild(td4); <!-- at cell to row -->
            
            var td5 = document.createElement('td'); <!-- creates new td for stop all-->
            s = document.createElement("input");
            setStopButton(s, " all");
            s.type = "image";
            td5.appendChild(s); <!-- adds child cell to td -->
            td5.className = "image";
            td5.onclick = function()    <!--add click event for stop all button--> 
            {
            	var cues = new Array(); <!--Array that will hold all nodeArrays attached to each Cue in the active cue-->
				for(var j in activeCueArray){
					for (var i in globalProduction.cueArray){
						if(globalProduction.cueArray[i].name == activeCueArray[j].childNodes[1].innerHTML)
							cues.push(globalProduction.cueArray[i].nodeArray);
					}
				}
				var jstring = JSON.stringify({nodes: cues, prodName: globalProduction.name});
				$.ajax({
					type: "POST",
					url: "ControllerPage.aspx/sendStopAll",
					data: jstring,
					contentType: "application/json; charset=utf-8",
				});
				
				while (tbdy.firstChild)
				{tbdy.removeChild(tbdy.firstChild);}
            
				while (activeArea.firstChild)			<!-- deletes elements in the active cue -->
	        	{activeArea.removeChild(activeArea.firstChild);}
	        	
	        	while (activeAreaTitle.firstChild)		<!-- deletes the active cue Title -->
	        	{activeAreaTitle.removeChild(activeAreaTitle.firstChild);}
	        	
	        	while (activeAreaFooter.firstChild)		<!-- deletes the active pause/play/delete all table -->
	        	{activeAreaFooter.removeChild(activeAreaFooter.firstChild);}
			    
			    activeCueArray = [];					<!-- resets the active cue to empty array-->
			    sidebaractive.style.display = 'none';		<!-- hides entire active cue area -->		        	           	
				updateProduction();			<!--updates background color for cuelist--> 
				for(var t in timerArray){
					clearInterval(timerArray[t]);
				}
				timerArray = new Array();
			}
			tr2.appendChild(td5);
			td5.style.borderColor = "gray";
			td4.style.borderColor = "gray";
			tbl2.style.borderColor = "gray"; 				<!--add td to row(tr)-->
			tbdy2.appendChild(tr2); 			<!--add row(tr) to tbdy-->                            	
            tbl2.style.width = "30%";
			tbl2.setAttribute('border','1');
			tbl2.appendChild(tbdy2);			<!--add tbdy to table--> 
			activeAreaFooter.appendChild(tbl2);  
        }
        
        function pauseAllTR(test2, time, c){
        	timerArray[c] = setInterval(function(){
				time -= 1;
				startTimer(time, test2.previousSibling);
			}, 1000);
        }

        function populateProduction(production) 	
        {        
        	while (cueArea.firstChild)			<!-- deletes elements in the cue area -->
	        {cueArea.removeChild(cueArea.firstChild);}
                                 	                             
			globalProduction = production;
			bigPlayButton.onclick = function() {playButton(globalProduction, tbdy)};
            var titleTable = document.createElement("table");
			var titleBody = document.createElement("tbody");
			var titleRow = document.createElement("tr");
			var emptyRow = document.createElement("tr");
			emptyRow.style.height = "10px";
			var td0 = document.createElement("td");
			var x = document.createTextNode("Production: " + globalProduction.name);
			td0.style.width = "30%";
			td0.appendChild(x);
			titleRow.appendChild(td0);
			
	        var td2 = document.createElement("td");
			titleRow.appendChild(td2);
			
			var td1 = document.createElement("td");
			td1.style.width = "1%";
			if(usertype == "Admin"){
				var addCue = document.createElement("input");
				addCue.type = "image";
				setAddButton(addCue);
				td1.appendChild(addCue);
				addCue.onclick = function()
				{
					$(this.parentNode.parentNode.parentNode.parentNode.nextSibling).slideToggle("fast");
					var delframe = this.parentNode.parentNode.parentNode.parentNode.nextSibling.firstChild.firstChild.firstChild;
					if(delframe.childNodes.length > 3){
						delframe.removeChild(delframe.lastChild);
					}
				}
			}
			titleRow.appendChild(td1);
			titleBody.appendChild(titleRow);
			titleBody.appendChild(emptyRow);
			titleTable.appendChild(titleBody);
			cueArea.appendChild(titleTable); <!--Title added to div -->
			if(usertype == "Admin"){
				createHiddenAddCueArea();
			}
			createProductionTable(globalProduction, tbdy);
			main.style.display = 'block';		<!-- makes main area visible -->
            divbutton_Cancel.style.display = 'none';	<!-- hides cancel button -->
            dropDownMenu.style.display = 'none';	<!-- ahides dropdown menu -->
            bigPlayButton.style.display = 'block';		<!-- makes play next button visible -->
            bigExitButton.style.display = 'block';	<!-- makes close button visible -->
            sliderArea.style.display = 'block';	<!-- makes volume slider visible -->
            
            <!-- creating warning image -->
            var warningImage = document.createElement("IMG");
			setGreenWarning(warningImage, true);<!-- true - Global (Cue) flag -->
			td2.className = "warning";
			td2.style.width = "1%";
			td2.appendChild(warningImage);
            
            updateProduction();				<!-- calls function to set cue background colors -->
            
		}
		
		<!-- creating hidden add Cue div -->
		function createHiddenAddCueArea(){
			var addCueDiv = document.createElement("div");
			addCueDiv.className = "productionSquare";
			addCueDiv.style.width = "100%";
			addCueDiv.style.display = "none";
			var newCueTable = document.createElement("table");
			
			var newCueBody = document.createElement("tbody");
			var newCueRow = document.createElement("tr");
			var newTd0 = document.createElement("td");
			newTd0.style.width = "20%";
			var box = document.createElement("input");
			box.type = "text";
			box.value = "New Cue Name";
			cueAreaStyle(box, newTd0);
			newCueRow.appendChild(newTd0);
			var td1 = document.createElement("td");
			td1.style.width = "20%";
			var dropDown = document.createElement("select");
			cueAreaStyle(dropDown, td1);
			populateSounds(dropDown);
			newCueRow.appendChild(td1);
			td2 = document.createElement("td");
			td2.style.width = "20%";
			createCue = document.createElement("BUTTON");
			createCueText = document.createTextNode("Create");
			cueAreaStyle(createCue, td2);
			createCue.appendChild(createCueText);
			createCue.onclick = function()
			{
				var tempRow = this.parentNode.parentNode;
				<!--cue name -->
				var newName = tempRow.firstChild.firstChild.value;
				<!--cue sound effect -->
				var newSound = tempRow.firstChild.nextSibling.firstChild.value;
				if(newName.length > 0 && newSound){
					var check = true;
					for(var j in globalProduction.cueArray){
						if(globalProduction.cueArray[j].name == newName)
							check = false;
					}
					if(check){
						<!--add newCue to end of GlobalArray.cueArray -->
						globalProduction.addCue(newName, newSound);
						var i = globalProduction.cueArray.length - 1;
						var newCueDiv = document.createElement("div");
		             	var newTable = document.createElement("table");
		       			var newTbdy = document.createElement("tbody");  
		       			newTbdy.className = "production";          	
		             	var newTrow = document.createElement("tr");
		             	newTrow.id = i.toString();		
		             	newTable.style.width = "100%";
						addCueToMain(i, globalProduction.cueArray[i], tbdy, newTbdy, newTrow, newTable, newCueDiv);
						cueArea.appendChild(newCueDiv);
						var linebreak = document.createElement("p");    <!--creates paragraph linebreak -->
          				cueArea.appendChild(linebreak);
						updateProduction();
						addCueDiv.style.display = "none";
						if(globalProduction.cueArray.length > 1)
						{
							<!--Makes down arrow visible for the cue that used to be on the bottom-->
							newCueDiv.previousSibling.previousSibling.firstChild.firstChild.firstChild.lastChild.firstChild.lastChild.lastChild.firstChild.style.display = 'block';
						}
						bigPlayButton.style.display = "block";
						<!--Save to file-->
						var dataValue = JSON.stringify({name: newName, sound: newSound, prodName: globalProduction.name});
						$.ajax({
							type: "POST",
							url: "ControllerPage.aspx/saveAddCue",
							data: dataValue,
							contentType: "application/json; charset=utf-8",
						});
					}
					else
						alert("Cue already exists");
				}
			}
			td2.style.display = 'none';
			newCueRow.appendChild(td2);
			newCueBody.appendChild(newCueRow);
			newCueTable.appendChild(newCueBody);
			addCueDiv.appendChild(newCueTable);
			cueArea.appendChild(addCueDiv);
       		var linebreak = document.createElement("p");    <!--creates paragraph linebreak -->
            cueArea.appendChild(linebreak);          <!--adds paragraph linebreak  after Title -->
       	}
       	
       	function cueAreaStyle(element, parent){
       		element.style.height = "25px";
			element.style.width = "70%";
			element.className = "nodeButton";
			parent.appendChild(element);
       	}
       	
       	function createTdElements(newTrow, text){
       		var newTd1 = document.createElement("td");
			var s = document.createTextNode(text);
            newTd1.appendChild(s);
            newTd1.className = "cuelist";
            newTd1.style.width = "25%";
			newTrow.appendChild(newTd1);
       	}
       	
       	function createProductionTable(globalProduction, tbdy, newCueDiv){
       		for(var i in globalProduction.cueArray)        <!--iterates through cue array and creates buttons -->
            {	
            	var newCueDiv = document.createElement("div");
             	var newTable = document.createElement("table");
       			var newTbdy = document.createElement("tbody");  
       			newTbdy.className = "production";          	
             	var newTrow = document.createElement("tr");
             	newTrow.id = i.toString();		
             	newTable.style.width = "100%";
             	addCueToMain(i, globalProduction.cueArray[i], tbdy, newTbdy, newTrow, newTable, newCueDiv);
             	cueArea.appendChild(newCueDiv);
             	var linebreak = document.createElement("p");    <!--creates paragraph linebreak -->
          		cueArea.appendChild(linebreak);				
			}
		}
			
        <!--creating div and Table for Edit Node (gear button)-->
        function createEditNodeTable(editNodeDiv){
			editNodeDiv.style.width = "100%";
			editNodeDiv.className = "production";
			var newNodeTable = document.createElement("table");
			newNodeTable.style.width = "50%";
			var newNodeBody = document.createElement("tbody");
			var newNodeRow1 = document.createElement("tr");

			<!--creating Edit Cue Button-->
			var td0 = document.createElement("td");
			td0.style.width = "33%";
			var x = document.createElement("BUTTON");
			xText = document.createTextNode("Edit Cue");
			cueAreaStyle(x, td0);
			x.appendChild(xText);
			x.onclick = function()
			{
				$(this.parentNode.parentNode.parentNode.parentNode.nextSibling).slideToggle("fast");
			}
			newNodeRow1.appendChild(td0);

			<!--creating Add Node Button-->
			var td1 = document.createElement("td");
			td1.style.width = "33%";
			var y = document.createElement("BUTTON");
			xText = document.createTextNode("Add Node");
			cueAreaStyle(y, td1);
			y.appendChild(xText);
			y.onclick = function()
			{
				$(this.parentNode.parentNode.parentNode.parentNode.nextSibling.nextSibling).slideToggle("fast");
			}
			newNodeRow1.appendChild(td1);
			newNodeBody.appendChild(newNodeRow1);
			newNodeTable.appendChild(newNodeBody);
			editNodeDiv.appendChild(newNodeTable);
		}
		
		<!--creating Edit Cue Section-->
		function createEditCueTable(editNodeDiv, name){
			var editCueDiv = document.createElement("div");
			editCueDiv.style.width = "100%";
			editNodeDiv.appendChild(editCueDiv);
			editCueDiv.style.display = "none";
			var linebreak = document.createElement("p"); <!--creates paragraph linebreak -->
			editCueDiv.appendChild(linebreak); <!--adds paragraph linebreak -->
			var editCueTable = document.createElement("table");
			var editCueBody = document.createElement("tbody");
			editCueBody.style.width = "50%";
			var editCueRow = document.createElement("tr");
			var td0 = document.createElement("td");
			td0.style.width = "28%";
			var newCueName = document.createElement("input");
			newCueName.type = "text";
			newCueName.value = name;
			newCueName.style.width = "33%";
			cueAreaStyle(newCueName, td0);
			editCueRow.appendChild(td0);
			var td1 = document.createElement("td");
			td1.style.width = "33%";
			var dropDown = document.createElement("select");
			
			var dataValue = "{name: '" + globalProduction.name + "'}";
        	$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/getSoundNames",
				data: dataValue,
				contentType: "application/json; charset=utf-8",
				success: function(files){
					for(var i in files.d){
						var option = document.createElement("option");
						option.text = files.d[i];
						option.value = files.d[i];
						dropDown.appendChild(option);
					}
					var option = document.createElement("option");
					option.value = "Import Sound";
					option.text = "Import Sound";
					option.onclick = function(){
						if(!this.parentNode.parentNode.nextSibling.nextSibling){
							this.parentNode.parentNode.style.width = "20%";
							this.parentNode.parentNode.nextSibling.style.width = "20%";
							this.parentNode.parentNode.previousSibling.style.width = "20%";
							editCueCheck = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.firstChild.firstChild.id;
							var frame = document.createElement("IFRAME");
							frame.setAttribute("src", "UploadFiles.aspx");
							frame.style.width = "100%";
							frame.style.height = "70px";
							frame.frameBorder = "0";
							dropDown.parentNode.parentNode.appendChild(frame);
						}
					}
					dropDown.appendChild(option);
				}
			});
			
			cueAreaStyle(dropDown, td1);
			editCueRow.appendChild(td1);
			var td2 = document.createElement("td");
			td2.style.width = "33%";
			var editSubmit = document.createElement("BUTTON");
			var editSubmitText = document.createTextNode("Edit");
			cueAreaStyle(editSubmit, td2);
			editSubmit.appendChild(editSubmitText);
			editSubmit.onclick = function()
			{
				var temp = this.parentNode.parentNode.parentNode.parentNode.parentNode;
				$(temp).slideToggle("fast");
				if(newCueName.value.length > 0 && dropDown.value.length > 0){
					var index = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.firstChild.firstChild.id;
					globalProduction.cueArray[index].name = newCueName.value;
					globalProduction.cueArray[index].sound = dropDown.value;
					for(var i in globalProduction.cueArray[index].nodeArray){
						globalProduction.cueArray[index].nodeArray[i].sound = dropDown.value;
					}
					var oldCueName = temp.parentNode.previousSibling.firstChild.firstChild.firstChild.nextSibling.innerHTML;
					temp.parentNode.previousSibling.firstChild.firstChild.firstChild.nextSibling.innerHTML = newCueName.value;
					temp.parentNode.previousSibling.firstChild.firstChild.firstChild.nextSibling.nextSibling.innerHTML = dropDown.value;
					temp.parentNode.previousSibling.firstChild.firstChild.childNodes[6].firstChild.title = "Delete " + newCueName.value;
					var dataValue = JSON.stringify({name: newCueName.value, sound: dropDown.value, prodName: globalProduction.name, oldname: oldCueName});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/saveCueEdits",
						data: dataValue,
						contentType: "application/json; charset=utf-8",
					});
				}
			}
			editCueRow.appendChild(td2);
			editCueBody.appendChild(editCueRow);
			editCueTable.appendChild(editCueBody);
			editCueDiv.appendChild(editCueTable);
		}
			
		<!--creating Add Node Section-->
		function createAddNodeTable(editNodeDiv, newCue, i){
			var addNodeDiv = document.createElement("div");
			addNodeDiv.style.width = "100%";
			editNodeDiv.appendChild(addNodeDiv);
			addNodeDiv.style.display = "none";
			var linebreak = document.createElement("p"); <!--creates paragraph linebreak -->
			addNodeDiv.appendChild(linebreak); <!--adds paragraph linebreak -->
			var addNodeTable = document.createElement("table");
			var addNodeBody = document.createElement("tbody");
			addNodeBody.style.width = "50%";
			var addNodeRow = document.createElement("tr");
			var td0 = document.createElement("td");
			td0.style.width = "15%";
			var dropDown = document.createElement("select");
			dropDown.className = "nodeButton";
			dropDown.style.height = "25px";
			dropDown.style.width = "35%";
			createNodeDropdown(dropDown, i);
			
			td0.appendChild(dropDown);
			addNodeRow.appendChild(td0);
			addNodeBody.appendChild(addNodeRow);
			addNodeTable.appendChild(addNodeBody);
			addNodeDiv.appendChild(addNodeTable);
			linebreak = document.createElement("p"); <!--creates paragraph linebreak -->
			editNodeDiv.appendChild(linebreak); <!--adds paragraph linebreak -->
		}
		
		function createNodeDropdown(dropDown, i) {
			$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/getNodeList",
				contentType: "application/json; charset=utf-8",
				success: function(nodes){
					if(nodes.d.length == 0)
						{ dropDown.style.display = "none"; }
					else
						{ dropDown.style.display = "block"; }
					for(var l in nodes.d){
						var check = true;
						for(var j in globalProduction.cueArray[i].nodeArray){<!--Checks if the node is already assigned to cue-->
							if(globalProduction.cueArray[i].nodeArray[j].name == nodes.d[l].getName){
								check = false;
								break;
							}
						}
						if(check){
							var option = document.createElement("option");
							option.text = nodes.d[l].getName;
							option.value = nodes.d[l].getName;
							option.onclick = function() {
								if(dropDown.length == 1)
								{ dropDown.style.display = "none"; }
								else
								{ dropDown.style.display = "block"; }
								var temp = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling;
								var i = temp.parentNode.previousSibling.firstChild.firstChild.id;
								var k = globalProduction.cueArray[i].nodeArray.length;
								<!--Change to whatever the defaults will be-->
								globalProduction.cueArray[i].addNode(this.value, "50.0", 0, 0, "0.0", 0, globalProduction.cueArray[i].sound);
								createCueNodes(i, k, temp.parentNode.nextSibling);
								var dataValue = JSON.stringify({name: this.value, prodName: globalProduction.name, cueName: globalProduction.cueArray[i].name});
								$.ajax({
									type: "POST",
									url: "ControllerPage.aspx/saveAddNode",
									data: dataValue,
									contentType: "application/json; charset=utf-8",
								});
								this.parentNode.removeChild(this);
							}
							dropDown.appendChild(option);
						}
					}
				}
			});
		}
				
		<!-- Creating all Nodes in the Cue -->
		function createCueNodes(i, k, newDiv){
         	var eachNodeTable = document.createElement("table");
			var eachNodeBody = document.createElement("tbody");
			var eachNodeRow = document.createElement("tr");
			eachNodeRow.id = k.toString();
			<!-- creating plus td -->
			var td0 = document.createElement("td");
			var plusButton = document.createElement("input");
			setPlusButton(plusButton, true);  <!-- true - Edit Node -->
			plusButton.type = "image";
			plusButton.id = "plus";
			plusButton.className = "playCue";
			td0.appendChild(plusButton);
			td0.style.width = "5%";
			plusButton.onclick = function()
			{
				$(this.parentNode.parentNode.parentNode.parentNode.nextSibling).slideToggle("fast");
				if(this.parentNode.children[0].id == "plus")
				{
					setMinusButton(this.parentNode.children[0], true); <!-- true - Edit Node -->
					this.parentNode.children[0].id = "minus"
				}
				else
				{
					setPlusButton(this.parentNode.children[0], true); <!-- true - Edit Node -->
					this.parentNode.children[0].id = "plus"
				}
			}
			td0.appendChild(plusButton);
			eachNodeRow.appendChild(td0);
			<!-- creates Nodes td-->
			var td1 = document.createElement("td");
			var nodeName = document.createTextNode(globalProduction.cueArray[i].nodeArray[k].name); <!--set cue name-->
			td1.appendChild(nodeName);
			td1.className = "cuelist";
			td1.style.width = "85%";
			eachNodeRow.appendChild(td1);
			<!-- creating warning image -->
			var td2 = document.createElement("td"); <!--create new td-->
			var warningImage = document.createElement("IMG");
			var jstring = JSON.stringify({nodes: globalProduction.cueArray[i].nodeArray});
        	$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/checkNodesOnline",
				data: jstring,
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function(status){
					if(status.d){
						setGreenWarning(warningImage, false);<!-- false - not the Global production flag -->
					}
					else{
						setRedWarning(warningImage, false);
						globalWarning = false;
						if(usertype == "User")
							setRedWarning(newDiv.previousSibling.firstChild.firstChild.childNodes[3].firstChild, true);
						else
							setRedWarning(newDiv.previousSibling.previousSibling.firstChild.firstChild.childNodes[3].firstChild, true);
						
						setRedWarning(cueArea.firstChild.firstChild.firstChild.firstChild.nextSibling.firstChild, true);
					}
				}
			});
			td2.className = "warning";
			td2.style.width = "1%";
			td2.appendChild(warningImage);
			eachNodeRow.appendChild(td2);
			
			if(usertype == "Admin"){
	    		<!-- creating Delete Node Button td -->
	            var td3 = document.createElement("td");
	            deleteNode = document.createElement("input");
	            setStopButton(deleteNode, " " + globalProduction.cueArray[i].nodeArray[k].name);
	            deleteNode.type = "image";
	            deleteNode.id = "delete";
	            td3.appendChild(deleteNode);
	            td3.style.width = "1%";
	            deleteNode.onclick = function() 
				{
					
					var thisNodeId = parseInt(this.parentNode.parentNode.id);
					var thisCueId = parseInt(this.parentNode.parentNode.parentNode.parentNode.parentNode.previousSibling.previousSibling.childNodes[0].childNodes[0].id);
					var cueName1 = globalProduction.cueArray[thisCueId].name;
					var nodeName1 = globalProduction.cueArray[thisCueId].nodeArray[thisNodeId].name;
					
					<!-- removes node from globalProduction -->
					globalProduction.cueArray[thisCueId].nodeArray.splice(thisNodeId, 1);

					
					var dropDown = document.createElement("select");
					dropDown.className = "nodeButton";
					dropDown.style.height = "25px";
					dropDown.style.width = "35%";
					createNodeDropdown(dropDown, thisCueId);
					var oldDropdown = this.parentNode.parentNode.parentNode.parentNode.parentNode.previousSibling.lastChild.previousSibling.lastChild.firstChild.firstChild.firstChild;
					oldDropdown.removeChild(oldDropdown.firstChild);
					oldDropdown.appendChild(dropDown);
					
					<!-- removes node from page -->
					var parent = this.parentNode.parentNode.parentNode.parentNode.parentNode;
					var child = this.parentNode.parentNode.parentNode.parentNode;
					var index = Array.prototype.indexOf.call(parent.childNodes, child);  
					parent.removeChild(parent.childNodes[index]);
					parent.removeChild(parent.childNodes[index]);
					
					for(var c = index; c < parent.childElementCount;c = c+2)
					{
						parent.childNodes[c].firstChild.firstChild.id = index;
						index++;
					}
					updateProduction();	
				
					var dValue = JSON.stringify({nodeName: nodeName1, cueName: cueName1, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/saveDeleteNode",
						data: dValue,
						contentType: "application/json; charset=utf-8",
					});
				}
				eachNodeRow.appendChild(td3);
			}
			eachNodeBody.appendChild(eachNodeRow);
			eachNodeTable.appendChild(eachNodeBody);
			newDiv.appendChild(eachNodeTable);
			<!-- creating Node Div -->
			var nodeDiv = document.createElement("div");
			nodeDiv.className = "productionInner";
			var effectTable = document.createElement("table");
			var effectBody = document.createElement("tbody");
			var firstRow = document.createElement("tr");
			createEffectHeaders("Volume", firstRow, "17%");
			createEffectHeaders("Fade In", firstRow, "17%");
			createEffectHeaders("Fade Out", firstRow, "17%");
			createEffectHeaders("Pitch", firstRow, "17%");
			createEffectHeaders("Delay", firstRow, "17%");
			createEffectHeaders("", firstRow, "18%");
			effectBody.appendChild(firstRow);
			var secondRow = document.createElement("tr");
			createEffectElements(globalProduction.cueArray[i].nodeArray[k].volume, secondRow, true, false);
			createEffectElements(globalProduction.cueArray[i].nodeArray[k].fadein, secondRow, false, false);
			createEffectElements(globalProduction.cueArray[i].nodeArray[k].fadeout, secondRow, false, false);
			createEffectElements(globalProduction.cueArray[i].nodeArray[k].pitch, secondRow, true, true);
			createEffectElements(globalProduction.cueArray[i].nodeArray[k].delay, secondRow, false, false);
			
			
			if(usertype == "Admin"){
				var td5 = document.createElement("td");
				var saveEffects = document.createElement("BUTTON");
				var addNodeText = document.createTextNode("SAVE");
				saveEffects.style.width = "70%";
				saveEffects.style.height = "25px";
				saveEffects.appendChild(addNodeText);
				td5.appendChild(saveEffects);
				saveEffects.className = "nodeButton";
				saveEffects.onclick = function()
				{
					var nodeID = this.parentNode.parentNode.parentNode.parentNode.parentNode.previousSibling.firstChild.firstChild.id;
					var cueID = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.previousSibling.previousSibling.firstChild.firstChild.id;
					var tempNode = globalProduction.cueArray[cueID].nodeArray[nodeID];
					var tempRow = this.parentNode.parentNode;
					if(tempRow.firstChild.firstChild.value > 100)
						tempRow.firstChild.firstChild.value = "100.0";
					if(tempRow.firstChild.firstChild.value < 0 || tempRow.firstChild.firstChild.value == "")
						tempRow.firstChild.firstChild.value = "0.0";
					if(tempRow.childNodes[1].firstChild.value > 600000)
						tempRow.childNodes[1].firstChild.value = "600000";
					if(tempRow.childNodes[1].firstChild.value == "")
						tempRow.childNodes[1].firstChild.value = "0";
					if(tempRow.childNodes[2].firstChild.value > 600000)
						tempRow.childNodes[2].firstChild.value = "600000";
					if(tempRow.childNodes[2].firstChild.value == "")
						tempRow.childNodes[2].firstChild.value = "0";
					if(tempRow.childNodes[3].firstChild.value == "")
						tempRow.childNodes[3].firstChild.value = "0.0";
					if(tempRow.childNodes[3].firstChild.value > 100)
						tempRow.childNodes[3].firstChild.value = "100.0";
					if(tempRow.childNodes[3].firstChild.value < -100)
						tempRow.childNodes[3].firstChild.value = "-100.0";
					if(tempRow.childNodes[4].firstChild.value > 600000)
						tempRow.childNodes[4].firstChild.value = "600000";
					if(tempRow.childNodes[4].firstChild.value == "")
						tempRow.childNodes[4].firstChild.value = "0";
					
					if(tempRow.firstChild.firstChild.value.indexOf(".") < 0)
						tempRow.firstChild.firstChild.value = tempRow.firstChild.firstChild.value + ".0";
					if(tempRow.childNodes[3].firstChild.value.indexOf(".") < 0)
						tempRow.childNodes[3].firstChild.value = tempRow.childNodes[3].firstChild.value + ".0";	
					tempNode.volume = tempRow.firstChild.firstChild.value;
					tempNode.fadein = tempRow.childNodes[1].firstChild.value;
					tempNode.fadeout = tempRow.childNodes[2].firstChild.value;
					tempNode.pitch = tempRow.childNodes[3].firstChild.value;
					tempNode.delay = tempRow.childNodes[4].firstChild.value;
					
					var dataValue = JSON.stringify({nodes: tempNode, prodName: globalProduction.name, cueName: globalProduction.cueArray[cueID].name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/saveNodeEffects",
						data: dataValue,
						contentType: "application/json; charset=utf-8",
						dataType: "json",
					});
				}
				td5.style.width = "18%";
				secondRow.appendChild(td5);
			}
			effectBody.appendChild(secondRow);
			effectTable.appendChild(effectBody);
			nodeDiv.appendChild(effectTable);
			nodeDiv.style.display = "none";
			newDiv.appendChild(nodeDiv);
        }
        
        function createEffectHeaders(name, row, width){
        	td = document.createElement("td")
        	s = document.createTextNode(name); <!--set volume title-->
			td.appendChild(s);
			td.className = "cuelist";
			td.style.width = width;
			row.appendChild(td);
        } 
        
        function createEffectElements(value, row, period, neg){
        	td = document.createElement("td");
			box = document.createElement("input");
			box.type = "text";
			box.value = value;
			box.style.height = "20px";
			box.style.width = "70%";
			box.className = "textbox";
			if(usertype == "User")
				box.readOnly = true;
			box.onkeypress = function(event){
				if(neg){
					if((event.charCode > 47 && event.charCode < 59) || event.keyCode == 8 || event.charCode == 45 || event.charCode == 46){
						if(event.charCode == 46){	
							if(this.value.indexOf(".") > -1)
								return false;
						}
						if(event.charCode == 45){
							if(this.value.indexOf("-") > -1)
								return false;
							this.value = "-" + this.value;
							return false;
						}
						return true;
					}
				}
				else if(period){
					if((event.charCode > 47 && event.charCode < 59) || event.keyCode == 8 || event.charCode == 46){
						if(event.charCode == 46){	
							if(this.value.indexOf(".") > -1)
								return false;
						}
						return true;
					}
				}
				else{
					if((event.charCode > 47 && event.charCode < 59) || event.keyCode == 8)
						return true;
				}
				return false;
			}
			td.appendChild(box);
			td.style.width = "17%";
			row.appendChild(td);
        }
        
        <!--Gets a list of productions from the productions directory-->
        function loadList(type)
        {
            $.ajax({
				type: "POST",
				url: "ControllerPage.aspx/getProductions",
				contentType: "application/json; charset=utf-8",
				success: function(filesArray) {
					var files = filesArray.d;
					for (var k in files) {
	                    var option = document.createElement("option");
	                    option.text = files[k];
	                    option.value = files[k];
	                    option.onclick = function(){
	                    	while (createProdInner.firstChild)
        						{createProdInner.removeChild(createProdInner.firstChild);}
        					createProdInner.style.backgroundColor = "gray";
	                    	var prodName = this.value;
	                    	var dataValue = "{name: '" + prodName + "'}";
				        	$.ajax({
								type: "POST",
								url: "ControllerPage.aspx/checkProdPass",
								data: dataValue,
								contentType: "application/json; charset=utf-8",
								success: function(pass){
	                    			if(pass.d == null || pass.d == ""){
	                    				if(type == "load")
				                    		loadProduction(prodName);
				                    	else if(type == "delete")
				                    		deleteProduction(prodName);
	                    			}
	                    			else{
	                    				var middlediv = document.createElement('div');
							        	var lpass = document.createElement('LABEL');
							        	lpass.innerHTML = "Password:";
							        	lpass.style.fontSize = "15px";
							        	middlediv.appendChild(lpass);
							        	var txtPass = document.createElement('INPUT');
							        	txtPass.setAttribute("type", "password");
							        	txtPass.className = "textbox";
							        	txtPass.onkeypress = function(event){
							        		if(event.keyCode == 13){
							        			if(txtPass.value == pass.d){
						        					createProd.style.display = 'none';
								        			if(type == "load")
							                    		loadProduction(prodName);
							                    	else if(type == "delete")
							                    		deleteProduction(prodName);
								        		}
								        		else{
								        			alert("Passwords do not match");
								        		}
							        		}
							        	}
							        	middlediv.appendChild(txtPass);
							        	
							        	var divsubmit = document.createElement('div');
							        	var btnsubmit = document.createElement('BUTTON');
							        	var btnsubmittext = document.createTextNode("Submit");
							        	btnsubmit.className = "editButton";
							        	btnsubmit.onclick = function(){
						        			if(txtPass.value == pass.d){
						        				createProd.style.display = 'none';
							        			if(type == "load")
						                    		loadProduction(prodName);
						                    	else if(type == "delete")
						                    		deleteProduction(prodName);
							        		}
							        		else{
							        			alert("Passwords do not match");
							        		}
							        	}
							        	btnsubmit.appendChild(btnsubmittext);
							        	divsubmit.appendChild(btnsubmit);
							        	createProdInner.appendChild(middlediv);
							        	createProdInner.appendChild(divsubmit);
	                    				createProd.style.display = 'block';
	                    			}
	                    		}
	                    	});
	                    }
	                    dropDownMenu.add(option);
                    }
				}
			});
        }
        
        function deleteProduction(value){
			var dataValue = "{name: '" + value + "'}";
			$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/deleteProductionPass",
				data: dataValue,
				contentType: "application/json; charset=utf-8",
			});
			cueElementArray = [];
			globalProduction = [];
			pageLoad();
        }
        
        function loadProduction(filename)
        {
        	globalProduction = null;
        	cueElementArray = new Array();
        	ActiveCueArray = new Array();
        	createProd.style.display = 'none';
			var dataValue = "{name: '" + filename + "'}";
			<!--This JQuery calls loadProduction in the Code Behind and grabs all the data from the filename passed in and sets all the arrays in code behind with the data -->
			$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/loadProduction",
				data: dataValue,
				contentType: "application/json; charset=utf-8",
			});
						
			<!--All these JQuerys get the arrays from code behind and pass them into makeproduction() function -->
			$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/getCueArray",
				contentType: "application/json; charset=utf-8",
				success: function(cueArray) {
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/getNodeArray",
						contentType: "application/json; charset=utf-8",
						success: function(nodeArray) {
							$.ajax({
								type: "POST",
								url: "ControllerPage.aspx/getSoundArray",
								contentType: "application/json; charset=utf-8",
								success: function(soundArray) {
									
									$.ajax({
										type: "POST",
										url: "ControllerPage.aspx/getEffectArray",
										contentType: "application/json; charset=utf-8",
										success: function(effectArray) {	
											var production = makeProduction(cueArray.d, nodeArray.d, soundArray.d, effectArray.d, filename);
											populateProduction(production);
										}
									});
								}
							});
						}
					});
				}
			});
        }
        
        function createProduction(){
        	var label = document.createElement('LABEL');
        	label.className = "activeCueTitle";
        	label.innerHTML = "Create Production";
        	createProdInner.appendChild(label);
        	var div = document.createElement('div');
        	var div2 = document.createElement('div');
        	var lname = document.createElement('LABEL');
        	lname.innerHTML = "Name: ";
        	lname.style.fontSize = "15px";
        	div.appendChild(lname);
        	var textName = document.createElement('INPUT');
        	textName.setAttribute("type", "text");
        	textName.className = "textbox";
        	div.appendChild(textName);
        	var btnpass = document.createElement('BUTTON');
        	var btnpasstext = document.createTextNode("Require Password");
        	btnpass.style.marginLeft = "50px";
        	btnpass.className = "editButton";
        	btnpass.onclick = function(){
        		$(middlediv).slideToggle("fast");
        		$(bottomdiv).slideToggle("fast");
        	}
        	btnpass.appendChild(btnpasstext);
        	div2.appendChild(btnpass);
        	var loptional = document.createElement('LABEL');
        	loptional.innerHTML = "(optional)";
        	loptional.style.fontSize = "15px";
        	div2.appendChild(loptional);
        	
        	var middlediv = document.createElement('div');
        	var bottomdiv = document.createElement('div');
        	var lpass = document.createElement('LABEL');
        	lpass.innerHTML = "Password:";
        	lpass.style.fontSize = "15px";
        	middlediv.appendChild(lpass);
        	var txtPass = document.createElement('INPUT');
        	txtPass.setAttribute("type", "password");
        	txtPass.className = "textbox";
        	middlediv.appendChild(txtPass);
        	var lconfirm = document.createElement('LABEL');
        	lconfirm.innerHTML = "Confirm:";
        	lconfirm.style.marginLeft = "50px";
        	lconfirm.style.fontSize = "15px";
        	bottomdiv.appendChild(lconfirm);
        	var txtConfirm = document.createElement('INPUT');
        	txtConfirm.setAttribute("type", "password");
        	txtConfirm.className = "textbox";
        	bottomdiv.appendChild(txtConfirm);
        	
        	var divsubmit = document.createElement('div');
        	var btnsubmit = document.createElement('BUTTON');
        	var btnsubmittext = document.createTextNode("Create");
        	btnsubmit.className = "editButton";
        	btnsubmit.onclick = function(){
        		if(textName.value.length > 0){
        			if(txtPass.value == txtConfirm.value){
	        			var dataValue = JSON.stringify({pass: txtPass.value, name: textName.value});
	        			$.ajax({
							type: "POST",
							url: "ControllerPage.aspx/createProduction",
							data: dataValue,
							contentType: "application/json; charset=utf-8",
						});
	        			pageLoad();
	        		}
	        		else{
	        			alert("Passwords do not match");
	        		}
        		}
        	}
        	btnsubmit.appendChild(btnsubmittext);
        	divsubmit.appendChild(btnsubmit);
        	middlediv.style.display = 'none';
        	bottomdiv.style.display = 'none';
        	createProdInner.appendChild(div);
        	createProdInner.appendChild(div2);
        	createProdInner.appendChild(middlediv);
        	createProdInner.appendChild(bottomdiv);
        	createProdInner.appendChild(divsubmit);
        	createProd.style.display = 'block';
        }

        <!--OnClick Methods -->
        
        button_LoadProduction.onclick = function ()
        {
            emptyProduction();
            loadList("load");
            dropDownMenu.style.display = 'block';
            sidebarlcdproduction.style.display = 'none';
            divbutton_Cancel.style.display = 'block';
        }
        
        button_CreateProduction.onclick = function ()
        {
            emptyProduction();
            sidebarlcdproduction.style.display = 'none';
            divbutton_Cancel.style.display = 'block';
            createProduction();
        }
        
        button_DeleteProduction.onclick = function ()
        {
            emptyProduction();
            addDeleteWarning();
            loadList("delete");
            dropDownMenu.style.display = 'block';
            sidebarlcdproduction.style.display = 'none';
            divbutton_Cancel.style.display = 'block';
        }
        
        function addDeleteWarning(){
        	var warning = document.createElement('LABEL');
        	warning.style.color = 'Red';
        	warning.innerHTML = "Warning!: Make sure all nodes are online when deleting a production otherwise the production will return when offline nodes are put on the network.";
        	createProdInner.appendChild(warning);
        	createProdInner.style.backgroundColor = "black";
        	createProd.style.display = 'block';
        }
               
        function playButton(globalProduction, tbdy)
        {
    	    var index = -1;
     		for(var a in activeCueArray)
     		{
     			if(activeCueArray[a] == cueElementArray[nextCue])
     			{ index = a; }
     		}
     		
     		if(index >= 0)
     		{
     			removeFromActive(activeArea.firstChild.firstChild.childNodes[index].lastChild, true)
     		}
        	
        	var jstring = JSON.stringify({nodes: globalProduction.cueArray[nextCue].nodeArray, prodName: globalProduction.name});
        	$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/startSound",
				data: jstring,
				contentType: "application/json; charset=utf-8",
				dataType: "json",
			});
        	
        	activeCueArray.push(cueElementArray[nextCue]);	<!--loads just started cue into activeCueArray-->
        	if(activeCueArray.length == 1)
            {
             	populateActive(tbdy);	
            }
            else
            {       		
	        	addActiveRow(cueElementArray[nextCue], tbdy);	    
	        }
	        
	        nextCue++;
        	if(cueElementArray.length == nextCue)
        	{
        		bigPlayButton.style.display = "none";
        	}
			updateProduction();			<!--updates background color for cuelist-->       
        	sidebaractive.style.display = "block";      		                     
        }
        
        bigExitButton.onclick = function()
        {
        	var cues = new Array(); <!--Array that will hold all nodeArrays attached to each Cue in the active cue-->
			for(var j in activeCueArray){
				for (var i in globalProduction.cueArray){
					if(globalProduction.cueArray[i].name == activeCueArray[j].childNodes[1].innerHTML)
						cues.push(globalProduction.cueArray[i].nodeArray);
				}
			}
			var jstring = JSON.stringify({nodes: cues, prodName: globalProduction.name});
			$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/sendStopAll",
				data: jstring,
				contentType: "application/json; charset=utf-8",
			});
			globalProduction = [];
        	pageLoad();
        }
        
        divbutton_Cancel.onclick = function()
        {
			pageLoad();
        }
        
        <!--swaps two elements that are not right next to each other-->
        function exchangeElements(first, second)
		{
		    var tempFirst = first.nextSibling;
			var tempSecond = second.nextSibling;
			tempFirst.parentNode.removeChild(second);
			tempFirst.parentNode.removeChild(first);
			tempFirst.parentNode.insertBefore(second, tempFirst);
			tempSecond.parentNode.insertBefore(first, tempSecond);
		}
        
        <!--Sends user or admin to the correct page-->
        function clickNetwork(){
        	clearInterval(syncInterval);
        	$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/killBroadcaster",
				contentType: "application/json; charset=utf-8",
			});
        	if(usertype == "Admin"){
        		window.location.assign("NetworkPage.aspx");
        	}
        	else if(usertype == "User"){
        		window.location.assign("Default.aspx");
        	}
        }
        
        function addActiveRow(myCue, tbdy)
        {         		            		           		        		            		           		            		           		           		            		           		            		           		            		           		
	    	var tr = document.createElement('tr'); <!-- creating new row -->
	    	tr.style.background = '#FFFF66';
		    var td0 = document.createElement('td');
		    var text = myCue.childNodes[1].textContent;
		    var cueName = document.createTextNode(text);
		    td0.className = "activeCueTitle" 
		    td0.appendChild(cueName);
		    tr.appendChild(td0); 
		         
		    <!--time remaining text-->       
		    var td1 = document.createElement('td');
		    var jstring = JSON.stringify({sound: myCue.childNodes[2].innerHTML, prodName: globalProduction.name});
			$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/getSoundLength",
				data: jstring,
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function(sound){
					var name = td1.previousSibling.innerHTML;
					var delay = 0;
					for(var t in globalProduction.cueArray){
						if(globalProduction.cueArray[t].name == name){
							for(var q in globalProduction.cueArray[t].nodeArray){
								if(globalProduction.cueArray[t].nodeArray[q].delay > delay)
									delay = globalProduction.cueArray[t].nodeArray[q].delay;
							}
						}
					}
					delay = delay / 1000;
					var time = sound.d + delay;
					td1.innerHTML = time;
					tbdy.appendChild(tr);
					var timeInterval = setInterval(function(){
						time -= 1;
						startTimer(time, td1);
					}, 1000);
					timerArray.push(timeInterval);
				}
			});
		    td1.className = "activeCueTime";
		    td1.style.color = "black";
		    td1.style.fontWeight = "bold";
		    td1.className = "image";
		    tr.appendChild(td1);
		                
		    var td2 = document.createElement('td');		<!-- adding play/pause icon to row -->
		    var playPause = document.createElement("input");
		    setPauseButton(playPause, "");
		    playPause.type = "image";
		    td2.appendChild(playPause); 
		    td2.className = "image";
		    td2.id = "pause";
		    td2.onclick = function()	<!--add click event for play/pause button-->
		    {
		    	var nodearray = []; <!--Array that will hold the nodeArray for the selected cue-->
		    	var index;
				for (var i in globalProduction.cueArray){
					if(globalProduction.cueArray[i].name == this.previousSibling.previousSibling.innerHTML){
						nodearray = globalProduction.cueArray[i].nodeArray;
					}
				}
				<!--gets index in activeCueArray that timerArray object lives-->
				for (var i in activeCueArray){
					if(activeCueArray[i].firstChild.nextSibling.innerHTML == this.previousSibling.previousSibling.innerHTML){
						index = i;
					}
				}
				if(this.id == "play")
				{
			    	var jstring = JSON.stringify({nodes: nodearray, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/resumeSound",
						data: jstring,
						contentType: "application/json; charset=utf-8",
						dataType: "json",
					});
													
					setPauseButton(this.children[0], "");		<!-- changes images to pause -->
					this.id = "pause";
					<!--starts timer back up-->
					var time = td1.innerHTML;
					timerArray[index] = setInterval(function(){
						time -= 1;
						startTimer(time, td1);
					}, 1000);
				}
				else
				{
					var jstring = JSON.stringify({nodes: nodearray, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/pauseSound",
						data: jstring,
						contentType: "application/json; charset=utf-8",
						dataType: "json",
					});
												
					setPlayButton(this.children[0], "");<!-- changes images to play -->
					this.id = "play";
					
					clearInterval(timerArray[index]); <!--stops the timer at specified index-->
				}
			} 
		    tr.appendChild(td2); 

		    var td3 = document.createElement('td');<!-- adding delete icon to row -->
		    deleteActive = document.createElement("input");
		    setStopButton(deleteActive, " from active");
		    deleteActive.type = "image";
		    td3.appendChild(deleteActive); 
		    td3.className = "image";
		    td3.onclick = function()	<!--add click event for stop button--> 
		    {
		    	var index;
		    	for (var i in activeCueArray){
					if(activeCueArray[i].firstChild.nextSibling.innerHTML == this.previousSibling.previousSibling.previousSibling.innerHTML){
						index = i;
					}
				}
		    	removeFromActive(this, true);
				if(activeCueArray.length == 0)
				{
					sidebaractive.style.display = "none";  <!--hides active cue title if empty-->
				}
				updateProduction();
				clearInterval(timerArray[index]);
				timerArray.splice(index, 1);
			}   
		    tr.appendChild(td3); 					    <!--add td to table row-->
        }
        
        function startTimer(time, td1){
        	var timeRem = document.createTextNode(time);
			if(td1.firstChild)
				td1.removeChild(td1.firstChild);
			td1.appendChild(timeRem);
			if(0 > time){
				var index;
				for(var t in activeCueArray){
					if(activeCueArray[t].firstChild.nextSibling.innerHTML == td1.parentNode.firstChild.innerHTML)
						index = t;
				}
				removeFromActive(td1.nextSibling.nextSibling, false);
				if(activeCueArray.length == 0)
				{
					sidebaractive.style.display = "none";  <!--hides active cue title if empty-->
				}
				updateProduction();
				clearInterval(timerArray[index]);
				timerArray.splice(index, 1);
			}
        }
        
        function removeFromActive(element, check)
        {
        	if(check){
	    		var nodearray; <!--Array that will hold the nodeArray for the selected cue-->
				for (var i in globalProduction.cueArray){
					var temp1 = globalProduction.cueArray[i].name;
					var temp2 = element.previousSibling.previousSibling.previousSibling.innerHTML;
					if(temp1 == temp2){
						nodearray = globalProduction.cueArray[i].nodeArray;
					}
				}
				var jstring = JSON.stringify({nodes: nodearray, prodName: globalProduction.name});
				$.ajax({
					type: "POST",
					url: "ControllerPage.aspx/stopSound",
					data: jstring,
					contentType: "application/json; charset=utf-8",
					dataType: "json",
				});
	        }
			var k = element.parentNode.rowIndex;	<!--identifies clicked row index-->
			activeCueArray.splice(k, 1);		<!--removes clicked item from active cue array-->
			
			var del = element.parentNode;
			del.parentNode.removeChild(del);
        }
        
        function addCueToMain(i, newCue, tbdy, newTbdy, newTrow, newTable, newCueDiv)
        {
    	    var newTd0 = document.createElement("td");	<!--create new td-->
            var playimage = document.createElement("input");	
            setPlayButton(playimage, " cue");					<!--set play image-->
            playimage.type = "image";
         	newTd0.style.width = "5%";					<!--set width-->
         	newTd0.className = "playCue";
         	playimage.onclick = function()
         	{
         		var index = -1;
         		for(var a in activeCueArray)
         		{
         			if(activeCueArray[a] == this.parentNode.parentNode)
         			{ 
         				index = a; 
         				break;
         			}
         		}
         		
         		if(index >= 0)
         		{
         			removeFromActive(activeArea.firstChild.firstChild.childNodes[index].lastChild, true)
					clearInterval(timerArray[index]);
					timerArray.splice(index, 1);
         		}
         		
         		nextCue = parseInt(this.parentNode.parentNode.id) +1;	<!--reset next Cue based on current id +1-->
         		var nodearray = []; <!--Array that will hold the nodeArray for the selected cue-->
				for (var j in globalProduction.cueArray){
					if(globalProduction.cueArray[j].name == this.parentNode.nextSibling.innerHTML){
						nodearray = globalProduction.cueArray[j].nodeArray;
						break;
					}
				}
         		var jstring = JSON.stringify({nodes: nodearray, prodName: globalProduction.name});
	        	$.ajax({
					type: "POST",
					url: "ControllerPage.aspx/startSound",
					data: jstring,
					contentType: "application/json; charset=utf-8",
					dataType: "json",
				});
         		activeCueArray.push(this.parentNode.parentNode);		<!--places current cue into active cue-->
				
				if(activeCueArray.length == 1)
         		{
         			populateActive(tbdy);	
         		}
         		else
         		{       		
             		addActiveRow(this.parentNode.parentNode,activeArea.firstChild.firstChild);	
         		}
      			
         		updateProduction();							<!--sets cue background colors-->
         		if(cueElementArray.length == nextCue)
	        	{
	        		bigPlayButton.style.display = "none";
	        	}
         		else
         		{
         			bigPlayButton.style.display = "block";
         		}
         	}             	
            newTd0.appendChild(playimage);
			newTrow.appendChild(newTd0); <!--add to row-->
			newTbdy.appendChild(newTrow);
			
           	createTdElements(newTrow, newCue.name);  	<!-- creating name td -->
			createTdElements(newTrow, newCue.sound);	<!-- creating sound td -->

            <!-- creating warning image -->
            var newTd4 = document.createElement("td");
			var warningImage = document.createElement("IMG");
			var dataValue = JSON.stringify({sound: newCue.sound, prodName: globalProduction.name});
			$.ajax({
				type: "POST",
				url: "ControllerPage.aspx/checkSound",
				data: dataValue,
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function(status){
					if(status.d)
						setGreenWarning(warningImage, true);<!-- true - Global (Cue) flag -->
					else{
						setRedWarning(warningImage, true);
						newTd4.previousSibling.style.color = 'red';
						setRedWarning(cueArea.firstChild.firstChild.firstChild.firstChild.nextSibling.firstChild, true);
					}
				}
			});
			newTd4.className = "warning";
			newTd4.style.width = "1%";
			newTd4.appendChild(warningImage);
			newTrow.appendChild(newTd4);
			
			<!--Creating TDs for rest of cue elements-->
			var newTd5 = document.createElement("td");
			newTd5.style.width = "1%";
			var newTd6 = document.createElement("td");
         	newTd6.style.width = "1%";
            var newTd7 = document.createElement("td");
            newTd7.style.width = "1%";
            var newTd8 = document.createElement("td");
			newTd8.style.width = "1%";
			
			
            if(usertype == "Admin"){
	            <!-- creating gear image -->
				var gearButton = document.createElement("input");
				setGearButton(gearButton);
				gearButton.type = "image";
				newTd5.appendChild(gearButton);
				gearButton.onclick = function()
				{
					$(this.parentNode.parentNode.parentNode.parentNode.nextSibling).slideToggle("fast");
				}
				
				<!-- creating Delete Cue Button td -->
	            deleteCue = document.createElement("input");
	            setStopButton(deleteCue, " " + newCue.name);
	            deleteCue.type = "image";
	            deleteCue.id = "delete";
	            newTd7.appendChild(deleteCue);
	            deleteCue.onclick = function()
				{
					var thisCueId = parseInt(this.parentNode.parentNode.id);
					<!--makes up arrow invisible on replacing cue when deleting top cue-->
					if(thisCueId == 0 && globalProduction.cueArray.length > 1) { 				
						<!-- identifies current table -->
						var tempDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode;					
						<!-- identifies the table moving up to replace deleted cue-->
						var nextDiv = tempDiv.nextSibling.nextSibling;
						var temp = nextDiv.firstChild.firstChild.firstChild.childNodes[7];
						temp.firstChild.firstChild.firstChild.firstChild.style.display = "none";
					}
				
					<!--makes down arrow hidden on replacing cue when deleting bottom cue-->
					if(thisCueId == globalProduction.cueArray.length -1 && globalProduction.cueArray.length > 1) { 
						<!-- identifies current table -->
						var tempDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode;
						<!-- identifies the next table moving down to replace deleted cue -->
						var nextDiv = tempDiv.previousSibling.previousSibling;
						
						temp = nextDiv.firstChild.firstChild.firstChild.childNodes[7];
						var temp2 = temp.firstChild.firstChild.childNodes[1];
						temp2.firstChild.style.display = "none";
					}			

					var cueName = globalProduction.cueArray[thisCueId].name;
					<!-- removes cue from globalProduction -->
					globalProduction.cueArray.splice(thisCueId, 1);
					<!-- removes cue from cueElementArray -->
					cueElementArray.splice(thisCueId, 1);				
					<!-- decrements nextCue if deleted cue is before it in the list -->
					if(nextCue > thisCueId) { nextCue--; }
					<!-- updates id's after removing cue -->
					for(var c in cueElementArray)
					{
						cueElementArray[c].id = c;
					}
					<!-- removes cue from page -->
					var parent = this.parentNode.parentNode.parentNode.parentNode.parentNode; 
					parent.parentNode.removeChild(parent.previousSibling);
					parent.parentNode.removeChild(parent);
					updateProduction();
					
					var dValue = JSON.stringify({name: cueName, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/saveDeleteCue",
						data: dValue,
						contentType: "application/json; charset=utf-8",
					});
				}
				
				<!-- creating up/dwn td -->
				var smallTbl = document.createElement("table");
				var smallTbdy = document.createElement("tbody");

				<!-- creating up td -->
				var upTrow = document.createElement("tr");
				var upTd = document.createElement("td");
				var upimage = document.createElement("input");
				upimage.type = "image";
				setUpButton(upimage);
				upTd.appendChild(upimage);
				upTd.onclick = function()
				{
					<!-- identifies ID(index) of current table row -->
					var thisCueId = parseInt(this.parentNode.parentNode.parentNode.parentNode.parentNode.id);					
					<!--if swapping with next Cue, increment nextCue -->
					if(thisCueId == nextCue +1) { nextCue++; }
					<!--if swapping with next Cue, decrement nextCue-->
					else if(thisCueId == nextCue) { nextCue --; }  
					<!-- identifies cue at index in globalProduction -->
					var curElement = globalProduction.cueArray[thisCueId];
					<!-- swaps the id's of the two cues -->
					cueElementArray[thisCueId].id = thisCueId -1;
					cueElementArray[thisCueId -1].id = thisCueId;
					<!-- identifes table row that is to be moved up -->
					var tempElement = this.parentNode.parentNode.parentNode.parentNode.parentNode;
					<!-- identifies div to be moved up -->
					var tempDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
					<!-- identifies the next div being moved to -->
					var nextDiv = tempDiv.previousSibling.previousSibling;
					<!--makes up arrow visible on top node-->
					if(thisCueId == 1) { 
						var temp = nextDiv.firstChild.firstChild.firstChild.childNodes[7];
						temp.firstChild.firstChild.firstChild.firstChild.style.display = "block"; 
					}			
					<!--makes up arrow hidden on second node-->
					if(thisCueId == 1) { this.style.display = "none"; }
					<!--makes down arrow hidden on switching cue if it will be at bottom node-->
					if(thisCueId == globalProduction.cueArray.length -1) { 
						temp = nextDiv.firstChild.firstChild.firstChild.childNodes[7];
						var temp2 = temp.firstChild.firstChild.childNodes[1];
						temp2.firstChild.style.display = "none";
					}			
					<!--makes down arrow visible on switching cue if it was at the bottom node-->
					if(thisCueId == globalProduction.cueArray.length -1) { 
						temp = this.parentNode.parentNode.parentNode.firstChild.childNodes[1];
						temp.firstChild.style.display = "block"; 
					}			
					<!-- removes cue object being moved from globalProduction -->
					globalProduction.cueArray.splice(thisCueId, 1);
					<!-- removes table row element from cueElementArray  -->
					cueElementArray.splice(thisCueId, 1);									
					<!-- inserts the removed cue object at the new index of globalProduction -->
					globalProduction.cueArray.splice(thisCueId -1,0,curElement);
					<!-- inserts the table row element at the new index of cueElementArray -->
					cueElementArray.splice(thisCueId -1,0,tempElement);										
					<!-- assigns a variable to the upper table  -->
					var lowerDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;		
	         		<!-- assigns a variable to the lower table  -->
	         		var upperDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.previousSibling.previousSibling;			
					<!-- swaps the two tables  -->
					exchangeElements(upperDiv, lowerDiv);
					updateProduction();
					
					var dValue = JSON.stringify({bottomCueName: globalProduction.cueArray[thisCueId - 1].name, topCueName: globalProduction.cueArray[thisCueId].name, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/saveMoveCueUporDown",
						data: dValue,
						contentType: "application/json; charset=utf-8",
					});
				}
				<!--hides up arrow on top node-->
				if(i == 0) { upTd.style.display = "none"; } 

				<!-- creating down td -->
				var downTrow = document.createElement("tr");
				var downTd = document.createElement("td");
				var downimage = document.createElement("input");
				downimage.type = "image";
				setDownButton(downimage);
				downTd.appendChild(downimage);
				downTd.onclick = function(){
					<!-- identifies ID(index) of current table row -->
					var thisCueId = parseInt(this.parentNode.parentNode.parentNode.parentNode.parentNode.id);
					<!--if swapping with next Cue, decrement nextCue-->
					if(thisCueId == nextCue -1) { nextCue--; } 
					<!-- If moving next cue down,  increment next cue index by one -->
					else if(thisCueId == nextCue) { nextCue ++; }				
					<!-- identifies cue at index in globalProduction -->
					var curElement = globalProduction.cueArray[thisCueId];					
					<!-- swaps the ids of the two cues -->
					cueElementArray[thisCueId].id = thisCueId +1;
					cueElementArray[thisCueId +1].id = thisCueId;								
					<!-- identifes table row that is to be moved down -->
					var tempElement = this.parentNode.parentNode.parentNode.parentNode.parentNode;
					<!-- identifies table to be moved down -->
					var tempDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;
					<!-- identifies the next table being moved to -->
					var nextDiv = tempDiv.nextSibling.nextSibling;
					<!--makes up arrow visible at index 0-->
					if(thisCueId == 0) { this.parentNode.parentNode.parentNode.firstChild.firstChild.firstChild.style.display = "block"; } 
					<!--makes up arrow invisible on switching cue if it will be at top node-->
					if(thisCueId == 0) { 
						var temp = nextDiv.firstChild.firstChild.firstChild.childNodes[7];
						temp.firstChild.firstChild.firstChild.firstChild.style.display = "none"; 
					}
					<!--makes down arrow invisible when at second to last index-->
					if(thisCueId == globalProduction.cueArray.length -2) { this.style.display = "none"; }
					<!--makes down arrow visible if it was at the bottom node-->
					if(thisCueId == globalProduction.cueArray.length -2) { 
						temp = nextDiv.firstChild.firstChild.firstChild.childNodes[7];
						var temp2 = temp.firstChild.firstChild.childNodes[1];
						temp2.firstChild.style.display = "block";
					}
					<!-- removes cue object being moved from globalProduction -->
					globalProduction.cueArray.splice(thisCueId, 1);
					<!-- removes table row element from cueElementArray  -->
					cueElementArray.splice(thisCueId, 1);									
					<!-- inserts the removed cue object at the new index of globalProduction -->
					globalProduction.cueArray.splice(thisCueId +1,0,curElement);
					<!-- inserts the table row element at the new index of cueElementArray -->
					cueElementArray.splice(thisCueId +1,0,tempElement);												
					<!-- assigns a variable to the upper table  -->
					var upperDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode;		
	         		<!-- assigns a variable to the lower table  -->
	         		var lowerDiv = this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.nextSibling.nextSibling;					
					<!-- swaps the two tables  -->
					exchangeElements(upperDiv, lowerDiv);
					updateProduction();	
					
					var dValue = JSON.stringify({bottomCueName: globalProduction.cueArray[thisCueId].name, topCueName: globalProduction.cueArray[thisCueId + 1].name, prodName: globalProduction.name});
					$.ajax({
						type: "POST",
						url: "ControllerPage.aspx/saveMoveCueUporDown",
						data: dValue,
						contentType: "application/json; charset=utf-8",
					});
				}
				if(i == globalProduction.cueArray.length -1)
				{ downTd.style.display = "none"; } <!--hides down arrow on bottom node-->
				
				<!--Appending Table-->
				upTrow.appendChild(upTd);
				downTrow.appendChild(downTd);
				smallTbdy.appendChild(upTrow);
				smallTbdy.appendChild(downTrow);
				smallTbl.appendChild(smallTbdy);
				newTd8.appendChild(smallTbl);
			}	
            
            <!-- creating plus td -->
            
            plusButton = document.createElement("input");
            setPlusButton(plusButton, false);
            plusButton.type = "image";
            plusButton.id = "plus";
         	newTd6.appendChild(plusButton);
         	plusButton.onclick = function()
         	{
         		if(usertype == "Admin")
         			$(this.parentNode.parentNode.parentNode.parentNode.nextSibling.nextSibling).slideToggle("fast");
         		else
         			$(this.parentNode.parentNode.parentNode.parentNode.nextSibling).slideToggle("fast");
         		
         		if(this.parentNode.children[0].id == "plus")
         		{
         			setMinusButton(this.parentNode.children[0], false); 
         			this.parentNode.children[0].id = "minus"
         		}
         		else
         		{
         		    setPlusButton(this.parentNode.children[0], false);
         			this.parentNode.children[0].id = "plus"
         		}             	
         	}
         	
			newTrow.appendChild(newTd5);
            newTd6.appendChild(plusButton);
			newTrow.appendChild(newTd6);
			newTrow.appendChild(newTd7);
			newTrow.appendChild(newTd8);
			
			<!--add cue elements to arrays-->
          	cueElementArray[i] = newTrow;

			<!--creating Table for Nodes-->
         	newTbdy.appendChild(newTrow);				
         	newTable.appendChild(newTbdy);
			newCueDiv.appendChild(newTable);
			
			if(usertype == "Admin"){
				var editNodeDiv = document.createElement("div");
				createEditNodeTable(editNodeDiv);
				createEditCueTable(editNodeDiv, newCue.name);
				createAddNodeTable(editNodeDiv, newCue, i);
				newCueDiv.appendChild(editNodeDiv);
				editNodeDiv.style.display = "none";
			}
			
			<!-- creates new div for Nodes -->
			var nodeDiv = document.createElement("div");
			nodeDiv.style.width = "100%";
			nodeDiv.className = "production";
			for(var k in globalProduction.cueArray[i].nodeArray)
        	{
				createCueNodes(i, k, nodeDiv);
			} 
         	newCueDiv.appendChild(nodeDiv);
         	nodeDiv.style.display = "none";					<!-- sets collapsed by default -->
		}
        
        
        <!--Gets a list of sound file names from the sounds directory-->
        function populateSounds(dropDown){
        	var dataValue = "{name: '" + globalProduction.name + "'}";
            $.ajax({
				type: "POST",
				url: "ControllerPage.aspx/getSoundNames",
				data: dataValue,
				contentType: "application/json; charset=utf-8",
				success: function(namesArray) {
					for(var i in namesArray.d){
						var option = document.createElement("option");
						option.value = namesArray.d[i];
						option.text = namesArray.d[i];
						option.onclick = function(){
							dropDown.parentNode.nextSibling.style.display = 'block';
							dropDown.parentNode.nextSibling.firstChild.style.display = 'block';
							dropDown.parentNode.nextSibling.nextSibling.display = 'none';
						}
						dropDown.appendChild(option);
					}
					var option = document.createElement("option");
					option.value = "Import Sound";
					option.text = "Import Sound";
					option.onclick = function(){
						if(!this.parentNode.parentNode.nextSibling.nextSibling){
							var uploadTd = document.createElement("td");
							uploadTd.style.width = "45%";
							dropDown.parentNode.nextSibling.firstChild.style.display = 'none';
							var frame = document.createElement("IFRAME");
							frame.setAttribute("src", "UploadFiles.aspx");
							frame.style.width = "100%";
							frame.style.height = "70px";
							frame.frameBorder = "0";
							uploadTd.appendChild(frame);
							dropDown.parentNode.parentNode.appendChild(uploadTd);
						}
					}
					dropDown.appendChild(option);
				}
			});
        }
        
        function uploadSoundClick(){
        	if(editCueCheck.length > 0){
        		var element = cueElementArray[editCueCheck];
        		var dropDown = element.parentNode.parentNode.nextSibling.firstChild.nextSibling.lastChild.firstChild.firstChild.firstChild.nextSibling.firstChild;
        	}
        	else{
	        	var dropDown = cueArea.firstChild.nextSibling.firstChild.firstChild.firstChild.firstChild.nextSibling.firstChild;
			}
			
			while (dropDown.firstChild)
        	{dropDown.removeChild(dropDown.firstChild);}
        	setTimeout(function (){
				populateSounds(dropDown);
				dropDown.parentNode.parentNode.removeChild(dropDown.parentNode.parentNode.lastChild);
			}, 500);
			dropDown.parentNode.nextSibling.style.display = 'block';
			dropDown.parentNode.nextSibling.firstChild.style.display = 'block';
        }
    	</script>        
    <body>
<html>



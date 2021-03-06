<!--Production class constructor-->
var Production = function(name){
    this.cueArray = new Array();
    this.name = name;
}
            
<!--Production method to add a Cue to the cueArray in a production -->
Production.prototype.addCue = function(name, sound){
    this.cueArray.push(new Cue(name, sound));
};
            
<!--Cue Class constructor -->
var Cue = function(name, sound){
    this.name = name;
    this.sound = sound;
    this.nodeArray = new Array();
}
            
<!--Cue method to add a Node to the nodeArray in a cue -->
Cue.prototype.addNode = function(name, volume, fadein, fadeout, pitch, delay, sound){
    this.nodeArray.push(new Node(name, volume, fadein, fadeout, pitch, delay, sound));
};
            
<!--Node class constructor -->
var Node = function(name, volume, fadein, fadeout, pitch, delay, sound){
    this.name = name;
    this.volume = volume;
    this.fadein = fadein;
    this.fadeout = fadeout;
    this.pitch = pitch;
    this.delay = delay;
    this.sound = sound;
    this.key = sound + "_" + Math.floor((Math.random() * 10000) + 1); 
}


<!--Creates a production object from arrays passed in -->
function makeProduction(cueArray, nodeArray, soundArray, effectArray, filename) {
    var effectindex = 0;
    var nodeindex = 0;
    var newCueArray = new Array();
    var production = new Production(filename);  <!--Production object is created -->
    <!--Iterates through cue and sound arrays -->
    for (var j in cueArray){
	production.addCue(cueArray[j], soundArray[j]);  <!--Adds a cue to a new cue array to create a Production object -->
        var newNodeArray = new Array();
        var index = parseInt(nodeArray[nodeindex]);  <!--Gets amount of nodes in a cue -->
        for(i = 0; i < index; i++){  <!--Iterates through nodes of a cue -->
            production.cueArray[j].addNode(nodeArray[nodeindex + 1], 	effectArray[effectindex], 
           								effectArray[effectindex + 1], 
			           					effectArray[effectindex + 2],
			           					effectArray[effectindex + 3],
			           					effectArray[effectindex + 4],
										soundArray[j]);
            effectindex += 5; <!--Jumps to next set of effects in the effect array -->
            nodeindex += 1;
        } 
        nodeindex += 1;  <!--Adds one to account for the spot in the node array that represents the number of nodes in a cue -->
    }       	
    return production;
}

# Audio Command Listener

The Audio Command Listener listens for commands related to sounds. It than manages any sounds which may be running. 
The audiocommandlistener takes the following commands:
    
    start
    stop
    pause
    pauseall
    resume
    resumeall
    volume
    volumeall
    scalevolume
    scalevolumeall
    globalvolume
    pitch
    pitchall
    tempo
    tempoall
    remove
    gettimeinfo

--------------------------------------------------------------------------------------------------

The AudioCommandListener relies on the following dependencies
       
       gstreamer-sharp
       glib-sharp

----------------------------------------------------------------------------------------------------

To run install and run AudioCommandListener:

	$ ./autogen.sh
	$ sudo make install
	
	Then from the command line type "audio" and it will run like any
	other program in the command line. By doing a "make install" it 
	places the shortcut in /usr/local/bin and the .exe in /usr/local/lib.
	To play songs please pass the path to the file. 
	ie. /home/colton/Music/song.mp3. 
	
To just compile and not install the AudioCommandListener:

	$ make

Note: 
	To automatically gather and install all needed gstreamer-sharp, glib dependencies and 
	the mono runtime to build the AudioCommandListener run the INSTALL script. 

	$ ./INSTALL.sh

	You will need root access and have your sources configured on Debian to pull from the online
	sources instead of the CD. To configure the source repos on Debian go to /etc/apt/ 
	and double click on sources.list file, under "Other Software" uncheck the cdrom options 
	and click the "Add" button. From here add the suggested example location to the textbox
	and click "Add Source". The default repository for Debian Wheezy is 
	"deb http://http.us.debian.org/debian/ wheezy main"

To clean from a previous build:
	
	$ make clean


---------------------------------------------------------------------------------------------------------------

Primary Author:
	
	Colton Prettyman
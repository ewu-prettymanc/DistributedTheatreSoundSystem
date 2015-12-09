# Distributed Theatre Sound System 
# EWU Senior Project
# Fall 2014 - Winter 2015 

Run the INSTALL.sh script to install the Distributed Theatre Sound system. After this script the dtssmanager
will autostart on boot regardless of current user login. At the end of the script the option for a reboot
or an immediate start of the dtssmanager will be presented.

After the install script is ran the following programs can be run individually from the command line:

      $ audiocommandlistener
      $ broadcastlistener
      $ webapp

Or if you want to run audiocommandlistener, broadcastlistener, and webapp collectively by a threaded process 
manager run:

      $ dtssmanager

dtssmanager will spawn a thread for audiocommandlistener, broadcastlistener, and webapp.

-----------------------------------------------------------------------------------------------------------
NOTE: You may need to add executable permissions to execute this script and you will need sudo privileges.

      $ sudo chmod +x INSTALL.sh


To add yourself to the sudoers group:

      $ sudo visudo

And the following line after the 
    
    # User privilege specification
    root ALL=(ALL:ALL) ALL
    your_user_name_here ALL=(ALL:ALL) ALL ----> add this line here 

Then press Ctrl-X and Y and than ENTER to save and exit.

--------------------------------------------------------------------------------------------------------------

Authors:

	Andrew Swalmsley <swalmsley17@eagles.ewu.edu>	       
	Colton Prettyman <konakidvw@gmail.com>
	Eric Meldrum <ericmeldrum@hotmail.com>
	Jared Hutton <jhutton@eagles.ewu.edu>
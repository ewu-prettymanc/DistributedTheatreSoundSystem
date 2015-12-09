# SSH Setup and Removal Scripts

After running the install script ssh via root user will work as well as the current user.
      
    $ ssh root@raspberrypi

------------------------------------------------------------------------------------------------------------------

To set up the ssh keys on your machine type:
    
    $ chmod +x .sshSetup.sh
    $ ./sshSetup.sh

To remove the ssh setup configurations type:

    $ chmod +x .sshRemove.sh
    $ ./sshRemove.sh


To ssh into a host automatically use the following options:
  
    $ ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConnectTimeout=5 pi@10.0.0.0 
    $ rsync -avz -e "ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o ConectTimeout=5" --progress /root/bigfile.txt pi@198.211.117.129:/root/

Where 10.0.0.0 is the address of the pi at hand

------------------------------------------------------------------------------------------------------------------

Primary Author:
	
	Colton Prettyman

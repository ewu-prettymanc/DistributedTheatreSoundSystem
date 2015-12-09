#!/bin/bash

#################################
# Colton Prettyman
# Fall 2014 - Winter 2015
# Senior Project EWU
# Team 6
#################################

#######################DESCRIPTION################################
# This script does undoes consequential changes made by the INSTALL
# script. Specifically the removing of the DTTS software.
# This script also restores SSH settings and sources change
# to install DTTS dependencies. This script does NOT uninstall
# dependencies installed by the INSTALL script. Only DTSS 
# specific and consequential changes. 
###################################################################

if [[ $1 == "--help" ]]; then
    echo "Usage ./INSTALL.sh (optional) --force"
    echo "--force            Force uninstall of dependencies installed by INSTALL script"
    echo "                   Be sure you actually want to...you probably don't want --force"
    echo "--source           Resets the source.list files to their backups"
    exit 0
fi

INSTALL_PATH=/usr/local/lib/dtss

sudo chmod +x INSTALL.sh

#------------------------------------------BEGIN SHH REMOVAL-------------------------------------------#

echo "------------------Begin SSH Removal----------------------"
cd  SSH

sudo chmod +x sshRemove.sh
sudo chmod +x sshSetup.sh

./sshRemove.sh

cd ..

echo "------------------End SSH Removal------------------------"

#------------------------------------------END SHH REMOVAL----------------------------------------------#

echo

#------------------------------------------BEGIN DTSS REMOVAL-------------------------------------------#

echo "------------------Begin DTSS Removal------------------------"

# kill running DTSS scripts if needed
echo "   ** Checking for DTSS running instances"
while read line
do
    echo "killing "$line
    sudo kill $line
done < <(ps aux | grep mono | grep 'audiocommandlistener.exe\|dtssmanager.exe\|broadcastlistener.exe\|xsp4.exe' | awk '{print $2}')


# end app killing

echo "** Removing $INSTALL_PATH"
if [[ -e $INSTALL_PATH ]] ;then
    echo "   ** Removing $INSTALL_PATH"
    sudo rm -rf $INSTALL_PATH
else
    echo "   ** $INSTALL_PATH does not need removal"
fi

echo "** Removing audiocommandlistener"
# usr/local/bin/audiocommandlistener
if [[ -e /usr/local/bin/webapp ]]; then
    echo "   ** Removing /usr/local/bin/audiocommandlistener"
    sudo rm -f /usr/local/bin/audiocommandlistener
else
    echo "   ** /usr/local/bin/audiocommandlistener does not need removal"
fi

echo "** Removing broadcastlistener"
# usr/local/bin/broadcastlistener
if [[ -e /usr/local/bin/broadcastlistener ]]; then
    echo "   ** Removing /usr/local/bin/broadcastlistener"
    sudo rm -f /usr/local/bin/broadcastlistener
else
    echo "   ** /usr/local/bin/broadcastlistener does not need removal"
fi


echo "** Removing webapp"
# usr/local/bin/webapp
if [[ -e /usr/local/bin/webapp ]]; then
    echo "   ** Removing /usr/local/bin/webapp"
    sudo rm -f /usr/local/bin/webapp
else
    echo "   ** /usr/local/bin/webapp does not need removal"
fi

echo "** Removing dtssmanager"
# usr/local/bin/dtssmanager
if [[ -e /usr/local/bin/dtssmanager ]]; then
    echo "   ** Removing /usr/local/bin/dtssmanager"
    sudo rm -f /usr/local/bin/dtssmanager
else
    echo "   ** /usr/local/bin/dtssmanager does not need removal"
fi

echo "** Removing dtssmanager auto-start"
# /etc/init.d/dtssmanagerinit
if [[ -e /etc/init.d/dtssmanagerinit ]]; then
    echo "   ** Removing /etc/init.d/dtssmanager"
    sudo update-rc.d -f dtssmanagerinit remove 
    sudo rm -f /etc/init.d/dtssmanagerinit
else
    echo "   ** /etc/init.d/dtssmanagerinit does not need removal"
fi

echo "------------------End DTSS Removal--------------------------"

#------------------------------------------END DTSS REMOVAL---------------------------------------------#

echo

#------------------------------------------BEGIN FORCE--------------------------------------------------#

if [[ $1 == "--force" ]]; then
    echo "------------------Begin Force Dependency Removal--------------------------"

    echo "Do you really want to uninstall all dependencies? Press CTRL-C to quit"
    sleep 10

    sudo apt-get -y --force-yes purge mono-complete
    sudo apt-get -y --force-yes purge autoconf
    sudo apt-get -y --force-yes purge automake
    sudo apt-get -y --force-yes purge autotools-dev
    sudo apt-get -y --force-yes purge alsa-utils
    sudo apt-get -y --force-yes purge sox
    sudo apt-get -y --force-yes purge gstreamer0.10-fluendo.mp3
    sudo apt-get -y --force-yes purge gstreamer0.10-alsa 
    sudo apt-get -y --force-yes purge gstreamer0.10-pulseaudio 
    sudo apt-get -y --force-yes purge gstreamer0.10-plugins-base
    sudo apt-get -y --force-yes purge gstreamer0.10-plugins-bad
    sudo apt-get -y --force-yes purge rsync
    sudo apt-get -y --force-yes purge libsox-fmt-all
    echo "------------------End Force Dependency Removal----------------------------"

fi

#------------------------------------------END FORCE----------------------------------------------------#

#------------------------------------------BEGIN SOURCES REMOVAL---------------------------------------#

if [[ $1 == "--source" || $1 == "--force" ]]; then
    echo "------------------Begin Sources Removal------------------"
    
    # If on a pi different source operations will be needed
    res=$(cat /etc/issue | grep -c "Raspbian")
    
    # Only pull from latest source if not on Rasbian
    if [[ $res == 0 ]]; then
	
	if [[ -e "/etc/apt/sources.list.d/mono-xamarin.list" ]]; then
	    sudo rm /etc/apt/sources.list.d/mono-xamarin.list
	    sudo apt-get update
	fi
    else # on Rasbian OS
	update=0
	
	if [[ -e "/etc/apt/sources.list.bak" ]]; then 
	sudo mv /etc/apt/sources.list.bak /etc/apt/sources.list
	((update+=1))
	fi
	
	if [[ -e "/etc/apt/sources.list.d/raspi.list.bak" ]]; then
	    sudo mv /etc/apt/sources.list.d/raspi.list.bak /etc/apt/sources.list.d/raspi.list
	    ((update+=1))
	fi
	
	if [[ $update != 0 ]]; then
	    sudo apt-get update
	fi
    fi
    echo "------------------End Sources Removal---------------------"
fi
#------------------------------------------END SOURCES REMOVAL-----------------------------------------#

#!/bin/bash

#################################
# Colton Prettyman
# Fall 2014 - Winter 2015
# Senior Project EWU
# Team 6
#################################

#######################DESCRIPTION################################
# This script installs the necessary dependencies and libraries
# needed to run the distributed theatre sound system software
# This includes Gstreamer and its needed plugins for MP3 and WAV
# streaming support and also the Mono development libraries
# to execute the C# code.
###################################################################

if [[ $1 == "--help" ]]; then
    echo "Usage ./INSTALL.sh (optional) --force"
    echo "--force            Force operations otherwise auto-ignored"
    exit 0
fi

# Install ready means everything is present and we can go ahead and install
# Any catchable errors will toggle this flag to not install
INSTALL_PATH=/usr/local/lib/dtss
installReady=1

sudo chmod +x UNINSTALL.sh

#------------------------------------------BEGIN SOURCES SETUP---------------------------------------#

echo "------------------Begin Sources Setup-----------------"
# If on a pi different source operations will be needed
res=$(cat /etc/issue | grep -c "Raspbian")

# Only pull from latest source if not on Rasbian
if [[ $res == 0 ]]; then
    # Only add the new source if it doesn't already exist
    if [[ ! -e "/etc/apt/sources.list.d/mono-xamarin.list" || $1 == "--force" ]]; then
	echo "   ** Setting up mono sources"
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
	# Older Ubuntu releases (Ubuntu 12.10 and 12.04)
	#echo "deb http://download.mono-project.com/repo/debian wheezy-libtiff-compat main" | sudo tee -a /etc/apt/sources.list.d/mono-xamarin.list
	# mod_mono (Ubuntu 13.10 and later, Debian 8.0 and later)
	#echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | sudo tee -a /etc/apt/sources.list.d/mono-xamarin.list
	
	sudo apt-get update
    else
	echo "   ** Sources Up-To-Date"
    fi
else
    update=0
    
    # Only update if needed as it takes extra time if .bak files do not exist they will be
    # changed and an update will be needed
    if [[ ! -e "/etc/apt/sources.list.bak" || ! -e "/etc/apt/sources.list.d/raspi.list.bak" || $1 == "--force" ]]; then
	echo "   ** Changing sources to point to correct repos"
	update=1
	sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
	sudo mv /etc/apt/sources.list.d/raspi.list /etc/apt/sources.list.d/raspi.list.bak

	sudo cp Sources/sources.list /etc/apt/
	sudo cp Sources/raspi.list /etc/apt/sources.list.d/
    else
	echo "   ** Sources Up-To-Date"
    fi
    #sudo sed -i.bak "/deb-src/ s/^#//" /etc/apt/sources.list
    #sudo sed -i.bak "/deb-src/ s/^#//" /etc/apt/sources.list.d/raspi.list

    
    if [[ $update != 0 ]]; then
	sudo apt-get update
    fi
fi
echo "------------------End Sources Setup-------------------"

#------------------------------------------END SOURCES SETUP------------------------------------------#

echo

#------------------------------------------BEGIN MONO INSTALL-----------------------------------------#

# The package mono-devel should be installed to compile code.
#sudo apt-get -y --force-yes install mono-devel

# The package mono-complete should be installed to install everything - this should cover most cases
# of “assembly not found” errors.
sudo apt-get -y --force-yes install mono-complete

# The package referenceassemblies-pcl should be installed for PCL compilation support 
# - this will resolve most cases of “Framework not installed: .NETPortable” errors during software compilation.
#sudo apt-get -y --force-yes install referenceassemblies-pcl

#------------------------------------------END MONO INSTALL-------------------------------------------#

echo

#------------------------------------------BEGIN Gstreamer INSTALL------------------------------------#

echo "------------------Begin Gstreamer Setup-----------------"

# Check gstreamer is not already installed!
echo "   ** Checking for gstreamer-sharp..."

update=0

res=$(/sbin/ldconfig -p | grep -c "libgstreamer-0.10*")
if [[ $res == 0 ]]; then 
    update=1
fi

res=$(/sbin/ldconfig -p | grep -c "libgstreamersharpglue")
if [[ $res == 0 ]]; then
    update=1
fi

# If res == 0 that means gstreamersharp is not installed
if [[ $update == 1 || $1 == "--force" ]]; then
    echo "   ** Installing gstreamer-sharp"
    sudo apt-get -y --force-yes install autoconf
    sudo apt-get -y --force-yes install automake
    sudo apt-get -y --force-yes install autotools-dev
    # Get dependencies to build from source
    sudo apt-get -y --force-yes build-dep gstreamer-sharp
    sudo mkdir gst

    cd gst

    # Build the source
    sudo apt-get -b source gstreamer-sharp
    
    # Install the source (gstreamer-sharp)
    if [[ -e gstreamer-sharp-0.9.2 ]]; then
	cd gstreamer-sharp-0.9.2
	#sudo ./configure
	sudo make install
	cd ..
	
	# Install built package dependencies
	sudo dpkg -i monodoc-gstreamer-manual_0.9.2-4_all.deb
	
	if [[ -e libgstreamer0.9-cil_0.9.2-4_i386.deb ]]; then
	    sudo dpkg -i libgstreamer0.9-cil_0.9.2-4_i386.deb
	else
	    sudo dpkg -i libgstreamer0.9-cil_0.9.2-4_armhf.deb
	fi
	
	sudo dpkg -i libgstreamer0.10-cil-dev_0.9.2-4_all.deb
    fi

    cd ..
    sudo rm -r gst
    
    # Update the shared library cache
    rc=0
    $(sudo /sbin/ldconfig /usr/local/lib)
    rc=$?
    $(sudo /sbin/ldconfig /usr/lib)
    ((rc+=$?))
    if [[ $rc != 0 ]]; then
	echo "Error updating the library cache"
    fi
else
    echo "   ** gstreamer-sharp already installed"
fi # end gstreamersharp install



echo "------------------End Gstreamer Setup-----------------"
#-------------------------------------------END Gstreamer INSTALL--------------------------------#

echo

#-------------------------------------------BEGIN AUDIO SETUP------------------------------------#

echo "------------------Begin Audio Setup-------------------"

sudo apt-get -y --force-yes install alsa-utils
sudo apt-get -y --force-yes install sox

# Install plugins which will allow most any filetype and
# platform
sudo apt-get -y --force-yes install gstreamer0.10-fluendo.mp3
sudo apt-get -y --force-yes install gstreamer0.10-alsa 
sudo apt-get -y --force-yes install gstreamer0.10-pulseaudio 
sudo apt-get -y --force-yes install gstreamer0.10-plugins-base
sudo apt-get -y --force-yes install gstreamer0.10-plugins-bad
sudo apt-get -y --force-yes install libsox-fmt-all
echo "------------------End Gstreamer Setup------------------"

#-------------------------------------------END AUDIO SETUP--------------------------------------#

echo

#-------------------------------------------BEGIN SSH SETUP--------------------------------------#

echo "------------------Begin SSH Setup----------------------"

sudo apt-get -y --force-yes install rsync

cd SSH

sudo chmod +x sshSetup.sh
sudo chmod +x sshRemove.sh

./sshSetup.sh

cd ..

echo "------------------End SSH Setup------------------------"

#-------------------------------------------END SSH SETUP----------------------------------------#

echo
#-------------------------------------------BEGIN WEBBAP DEPENDENCIES----------------------------#

<<'COMMENT'

echo "------------------Begin WebApp Setup-------------------"

echo "   ** Looking for xsp4.exe"

# /usr/lib/mono/gac/xsp4/3.8.0.00738eb9f132ed756/xsp4.exe

# find the correct folder the xsp4.exe lives in 3.8.0*
folder=$(ls /usr/lib/mono/gac/xsp4/ | grep "3.8.0*")
if [[ $folder == "" ]];then
    echo "   ** xsp4.exe does not exist in /usr/lib/mono/gac/xsp4/"
else
    echo "   ** Copying xsp4.exe to the WEBAPP folder"
    cp "/usr/lib/mono/gac/xsp4/$folder/xsp4.exe" WEBAPP/
    sudo chmod +x WEBAPP/xsp4.exe
fi

echo "   ** Looking for Mono.Security.dll"
# /usr/lib/mono/gac/Mono.Security/4.0.0.00738eb9f132ed756/Mono.Security.dll

# find the correct folder the Mono.Security.dll lives in 4.0.0*
folder=$(ls /usr/lib/mono/gac/Mono.Security/ | grep "4.0.0*")
if [[ $folder == "" ]];then
    echo "   ** Mono.Security.dll 4.0.0 does not exist in /usr/lib/mono/gac/Mono.Security/"

    # /usr/lib/mono/gac/Mono.WebServer2/0.4.0.0__0738eb9f132ed756/Mono.WebServer2.dll

    # find the correct folder backup Mono.Security.dll lives in 2.0.0*
    echo "   ** Trying previous version 2.0.0"
    folder=$(ls /usr/lib/mono/gac/Mono.Security/ | grep "2.0.0*")
    if [[ $folder == "" ]];then
	echo "   ** Mono.Security.dll 2.0.0 does not exist in /usr/lib/mono/gac/Mono.Security/"	
    else
	echo "   ** Copying Mono.Security.dll 2.0.0 to the WEBAPP folder"
	cp "/usr/lib/mono/gac/Mono.Security/$folder/Mono.Security.dll" WEBAPP/
	sudo chmod +x WEBAPP/Mono.Security.dll
    fi
else
    echo "   ** Copying Mono.Security.dll 4.0.0 to the WEBAPP folder"
    cp "/usr/lib/mono/gac/Mono.Security/$folder/Mono.Security.dll" WEBAPP/
    sudo chmod +x WEBAPP/Mono.Security.dll
fi

echo "   ** Looking for Mono.Web.Server2.dll"
# /usr/lib/mono/gac/Mono.WebServer2/0.4.0.0__0738eb9f132ed756/Mono.WebServer2.dll
# find the correct folder the xsp4.exe lives in 3.8.0*
folder=$(ls /usr/lib/mono/gac/Mono.WebServer2/ | grep "0.4.0*")
if [[ $folder == "" ]];then
    echo "   ** Mono.Web.Server2.dll does not exist in /usr/lib/mono/gac/Mono.Webserver2/"
else
    echo "   ** Copying Mono.WebServer2.dll to the WEBAPP folder"
    cp "/usr/lib/mono/gac/Mono.WebServer2/$folder/Mono.WebServer2.dll" WEBAPP/
    sudo chmod +x WEBAPP/Mono.WebServer2.dll
fi

echo "------------------Begin WebApp Setup-------------------"

COMMENT

#-------------------------------------------END WEBBAP DEPENDENCIES------------------------------#

echo

#-------------------------------------------BEGIN AUDIO LISTENER---------------------------------#
echo "------------------Begin Audio Listener Setup-----------"

if [[ ! -e AudioCommandListener/bin/Release/AudioCommandListener.exe || $1 == "--force" ]]; then
    echo "   ** Building AudioCommandListener"
    cd AudioCommandListener/
    
    make clean

    # Install path is where we want to live!
    ./configure --libdir=$INSTALLPATH
    if [[ $? == 0 ]]; then
	echo "   ** Configure successful, now building..."
	make
	if [[ $? == 0 ]]; then
	    echo "   ** Build successful"
	else
	    echo "   ** Build failed!"
	    installReady=0
        fi
    else
	echo "Configure failed...broken dependencies?"
    fi
    
    cd ..
fi

if [[ -e AudioCommandListener/bin/Release/AudioCommandListener.exe ]]; then
    echo "   ** AudioCommandListener.exe exist, using that"
        installReady=1
fi

echo "------------------End  Audio Listener Setup------------"

#-------------------------------------------END AUDIO LISTENER-----------------------------------#

echo

#-------------------------------------------BEGIN BROADCAST LISTENER-----------------------------#
echo "------------------Begin Broadcast Listener Setup-------"

echo "   ** Checking for compiled BroadcastListener"
if [[ ! -e BroadcastListener/BroadcastListener.exe || $1 == "--force" ]]; then
    echo "   ** Building BroadcastListener"
    cd BroadcastListener/

    if [[ ! -e BroadcastListener/BroadcastListener.exe ]]; then
	make clean
    fi
  
    make all
    if [[ $? == 0 ]]; then
	echo "Build successfull"
    else
	echo "Build failed"
	installReady=0
    fi
    
    cd ..
fi

if [[ -e BroadcastListener/BroadcastListener.exe ]]; then
    echo "   ** BroadcastListener.exe exist, using that"
    installReady=1
fi

echo "------------------End Broadcast Listener Setup---------"

#-------------------------------------------END BROADCAST LISTENER-------------------------------#

#-------------------------------------------BEGIN DTSSManager------------------------------------#
echo "------------------Begin DTSS manager Setup-------------"

echo "   ** Checking for compiled DTSSManager"
if [[ ! -e DTSSManager/DTSSManager.exe || $1 == "--force" ]]; then
    echo "   ** Building DTSSManager"
    cd DTSSManager/

    if [[ ! -e DTSSManager/DTSSManager.exe ]]; then
	make clean
    fi
  
    make all
    if [[ $? == 0 ]]; then
	echo "Build successfull"
    else
	echo "Build failed"
	installReady=0
    fi
    
    cd ..
fi

if [[ -e DTSSManager/DTSSManager.exe ]]; then
    echo "   ** DTSSManager.exe exist, using that"
    installReady=1
fi

echo "------------------End Broadcast Listener Setup---------"

#-------------------------------------------END BROADCAST LISTENER-------------------------------#

echo

#-------------------------------------------BEGIN DTTS INSTALL-----------------------------------#

if [[ $installReady == 0 ]]; then
    echo 
    echo "Error: Unable to Install DTSS"
    echo
    
    exit 1
fi

echo "------------------Begin DTSS Installation-----------"

echo
echo "** Verifying directories"
echo "   ** Verifying directory $INSTALL_PATH"
sudo mkdir -p $INSTALL_PATH


echo "   ** Verifying directory $INSTALL_PATH/audiocommmandlistener"
sudo mkdir -p "$INSTALL_PATH/audiocommandlistener"

echo "   ** Verifying directory $INSTALL_PATH/broadcastlistener"
sudo mkdir -p "$INSTALL_PATH/broadcastlistener"

echo "   ** Verifying directory $INSTALL_PATH/webapp"
sudo mkdir -p "$INSTALL_PATH/webapp"
echo "** Directory verification complete"
echo

echo "** Copying AudioCommandListener files"
sudo chmod +x AudioCommandListener/bin/Release/AudioCommandListener.exe
sudo cp -f AudioCommandListener/bin/Release/AudioCommandListener.exe $INSTALL_PATH/audiocommandlistener/audiocommandlistener.exe
sudo chmod +x LibScripts/audiocommandlistener
sudo cp -f LibScripts/audiocommandlistener /usr/local/bin/
echo "** AudioCommandListener file copy complete"

echo "** Copying BroadcastListener files"
sudo chmod +x BroadcastListener/BroadcastListener.exe
sudo cp -f BroadcastListener/BroadcastListener.exe $INSTALL_PATH/broadcastlistener/broadcastlistener.exe
sudo chmod +x LibScripts/broadcastlistener
sudo cp -f LibScripts/broadcastlistener /usr/local/bin/
echo "** BroadCastListener file copy complete"

echo "** Copying WebApp files"
sudo cp -rf WEBAPP/* $INSTALL_PATH/webapp/
sudo chmod +x LibScripts/webapp
sudo cp -f LibScripts/webapp /usr/local/bin
echo "** WebApp file copy complete"

echo "** Copying Script files"
sudo chmod +x Scripts/*
sudo cp -rf Scripts $INSTALL_PATH
echo "** Script file copy complete"

echo "** Copying DTSSManager files"
sudo chmod +x DTSSManager/DTSSManager.exe
sudo cp -f DTSSManager/DTSSManager.exe $INSTALL_PATH/dtssmanager.exe
sudo chmod +x LibScripts/dtssmanager
sudo cp -f LibScripts/dtssmanager /usr/local/bin
echo "** DTSSManager file copy complete"

echo "** Adding DTSSManager to auto-start on boot"
sudo chmod +x LibScripts/dtssmanagerinit
sudo cp -f LibScripts/dtssmanagerinit /etc/init.d/
sudo update-rc.d dtssmanagerinit defaults
echo "** DTSSManager auto-start complete"

sudo chmod -R 777  $INSTALL_PATH
echo "------------------DTSS Installation Complete--------------"

echo
echo "To run the AudioCommandListener type:                $ sudo audiocommandlistener start"
echo "To run the BroadCastListener type:                   $ sudo broadcastlistener start"
echo "To run the WebApp type:                              $ sudo webapp start"
echo "To run the DTSSManager (runs all 3 above) type:      $ sudo dtssmanager start"


echo
echo "Enter a choice."
echo "1 - Reboot"
echo "2 - Start DTSS"
echo "Or any other key to exit"
read choice

case "$choice" in
    2)
	echo
	echo "** Starting dtssmanager now..."
	sudo dtssmanager start
	if [[ $? == 0 ]]; then
	    echo "** dtssmanager exited gracefully"
	else
	    echo "dtssmanager was killed"
	fi
	;;
    1)
	echo "Rebooting in 5 seconds..."
	sleep 5
	sudo reboot
	;;
esac


#-------------------------------------------BEGIN DTTS INSTALL-----------------------------------#

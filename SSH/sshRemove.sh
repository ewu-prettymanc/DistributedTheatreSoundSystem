#!/bin/bash

#################################
# Colton Prettyman
# Fall 2014 - Winter 2015
# Senior Project EWU
# Team 6
#################################

#########################DESCRIPTION############################
# This script undoes everything done by the sshSetup.sh script.
# It is safe to run this script whether the setup script was
# ran or not. 
################################################################


# node_ssh_rsa_key.pub -- Public ssh key which goes in the sshd_config
# node_ssh_rsa_key     -- Private ssh key which is placed in the /.ssh directory
# /etc/ssh/             -- Directory where ssh configurations are placed
# /etc/ssh/ssh_config   -- File where ssh configurations are set
# /etc/ssh/sshd_config  -- File where ssh server configurations are set

# Install an openssh server
# sudo apt-get -y --force-yes purge openssh-server
# Make sure ssh and rsync are installed too
# sudo apt-get -y --force-yes install rsync
# sudo apt-get -y --force-yes isntall ssh

if [[ ! -e "/etc/ssh/sshd_config" ]]; then
    echo "ssh server not installed"
elif [[ ! -e "/etc/ssh/sshd_config.bak" ]]; then
    echo "ssh server config restore not needed"
else
    echo "Restoring ssh server config."
    sudo rm /etc/ssh/sshd_config
    sudo mv /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
fi

if [[ ! -e "/etc/ssh/ssh_config" ]]; then
    echo "ssh not installed"
elif [[ ! -e "/etc/ssh/ssh_config.bak" ]]; then
    echo "ssh config restore not needed"
else
    echo "Restoring ssh config."
    sudo rm /etc/ssh/ssh_config
    sudo mv /etc/ssh/ssh_config.bak /etc/ssh/ssh_config
fi

# begin root restore
sudo chmod 777 /root
sudo chmod -R 777 /root/.ssh

sudo rm -f /root/.ssh/node_ssh_rsa_key

if [[ ! -e /root/.ssh/authorized_keys ]]; then
    echo "No authorized keys for root"
elif [[ ! -e /root/.ssh/authorized_keys.bak ]]; then
    echo "Authorized key restore not needed for root"
else
    echo "Restoring authorized keys for root."
    rm  /root/.ssh/authorized_keys
    mv /root/.ssh/authorized_keys.bak /root/.ssh/authorized_keys
fi

# Remove the file if empty
if [[ -e /root/.ssh/authorized_keys ]]; then
    if [[ $(cat /root/.ssh/authorized_keys) == "" ]]; then
	rm /root/.ssh/authorized_keys
    fi
fi

sudo chmod -R 600  /root/.ssh
sudo chmod 700 /root/.ssh
sudo chmod 700 /root
sudo chown -R root:root /root/.ssh
# end root restore

# start user restore
sudo rm -f /etc/ssh/node_ssh_rsa_key
sudo rm -f ~/.ssh/node_ssh_rsa_key

if [[ ! -e ~/.ssh/authorized_keys ]]; then
    echo "No authorized keys"
elif [[ ! -e ~/.ssh/authorized_keys.bak ]]; then
    echo "Authorized key restore not needed"
else
    echo "Restoring authorized keys."
    rm  ~/.ssh/authorized_keys
    mv ~/.ssh/authorized_keys.bak ~/.ssh/authorized_keys
fi

# Remove the file if empty
if [[ -e ~/.ssh/authorized_keys ]]; then
    if [[ $(cat ~/.ssh/authorized_keys) == "" ]]; then
	rm ~/.ssh/authorized_keys
    fi
fi

sudo chmod -R 600 ~/.ssh
sudo chmod 700 ~/.ssh
# end user restore
sudo service ssh restart

echo "ssh restore complete!"

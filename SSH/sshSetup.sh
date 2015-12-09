#!/bin/bash

#################################
# Colton Prettyman
# Fall 2014 - Winter 2015
# Senior Project EWU
# Team 6
#################################

#########################DESCRIPTION############################
# This script setups up public and private ssh keys both
# for client and host authentication. It also adds the
# keys to the ssh_config and sshd_config files for global
# ssh use. These keys are added to the authorized_host files
# as well to automate ssh connections as much as possible
################################################################


# node_ssh_rsa_key.pub -- Public ssh key which goes in the sshd_config
# node_ssh_rsa_key     -- Private ssh key which is placed in the /.ssh directory
# /etc/ssh/             -- Directory where ssh configurations are placed
# /etc/ssh/ssh_config   -- File where ssh configurations are set
# /etc/ssh/sshd_config  -- File where ssh server configurations are set

echo "ssh node setup begin..."

sudo chmod 600 node_ssh_rsa_key
sudo chmod 644 node_ssh_rsa_key.pub

# Install an openssh server
if [[ ! -e "/etc/ssh/sshd_config" ]]; then
    echo "Installing openssh"
    sudo apt-get -y --force-yes install openssh-server
    sudo service ssh start
fi

# Make sure ssh and rsync are installed too
if [[ ! -e "/usr/bin/rsync" ]]; then
    echo "Installing rsync"
    sudo apt-get -y --force-yes install rsync
fi

if [[ ! -e "/etc/ssh/ssh_config" ]]; then
    echo "Installing ssh"
    sudo apt-get -y --force-yes install ssh
fi

# Back up ssh_config if not already
if [[ ! -e "/etc/ssh/ssh_config.bak" ]]; then
    echo "Backing up ssh_config file."
    sudo cp /etc/ssh/ssh_config /etc/ssh/ssh_config.bak
fi

# Back up sshd_config if not already
if [[ ! -e "/etc/ssh/sshd_config.bak" ]]; then
    echo "Backing up sshd_config file."
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
fi

# Check that the keys aren't already appended to the ssh_config file
res=$(cat /etc/ssh/ssh_config | grep 'node_ssh_rsa_key')
if [[ $res == "" ]]; then
    echo "Setting up ssh client keys."
    sudo bash -c "echo '    IdentityFile ~/.ssh/node_ssh_rsa_key' >> /etc/ssh/ssh_config"
#    sudo bash -c "echo '    StrictHostKeyChecking no' >> /etc/ssh/ssh_config"
#    sudo bash -c "echo '    BatchMode yes' >> /etc/ssh/ssh_config"
#    sudo bash -c "echo '    ConnectTimeout 5' >> /etc/ssh/ssh_config"	
fi

# Check that the keys aren't already appended to the sshd_config file
res=$(cat /etc/ssh/sshd_config | grep node_ssh_rsa_key)
if [[ $res == "" ]]; then
    echo "Setting up ssh server keys."
    sudo bash -c "echo 'HostKey /etc/ssh/node_ssh_rsa_key' >> /etc/ssh/sshd_config"
fi

# Make sure key is placed in /etc/ssh
if [[ ! -e "/etc/ssh/node_ssh_rsa_key" ]]; then
    echo "Copying node_ssh_rsa_key to /etc/ssh"
    sudo cp node_ssh_rsa_key /etc/ssh
fi

# Make sure key is placed in .ssh
if [[ ! -e ~/.ssh/node_ssh_rsa_key ]]; then
    echo "Copying node_ssh_rsa_key to ~/.ssh"
    mkdir -p ~/.ssh
    cp node_ssh_rsa_key ~/.ssh/
fi

# begin root ssh setup
sudo chmod 777 /root
sudo chmod -R 777 /root/.ssh
# Make sure key is placed into /root/.ssh
if [[ ! -e /root/.ssh/node_ssh_rsa_key ]]; then
    echo "Copying node_ssh_rsa_key to /root/.ssh for root ssh access"
    sudo mkdir -p /root/.ssh
    sudo cp node_ssh_rsa_key /root/.ssh/
fi

if [[ ! -e /root/.ssh/authorized_keys ]]; then
    echo "Creating authorized_keys root file"
    touch /root/.ssh/authorized_keys
fi

if [[ ! -e /root/.ssh/authorized_keys.bak ]]; then
    echo "Backing up authorized_keys root file."
    cp /root/.ssh/authorized_keys /root/.ssh/authorized_keys.bak
fi

# Check whether the key already exists in the authorized_keys file
key=$(awk '{print $2 }' node_ssh_rsa_key.pub)
res=$(cat /root/.ssh/authorized_keys | grep $key )
if [[ $res == "" ]]; then
    echo "Setting up ssh authorized keys for root."
    cat node_ssh_rsa_key.pub >> /root/.ssh/authorized_keys 
fi

sudo chmod -R 600 /root/.ssh
sudo chmod 700 /root/.ssh
sudo chmod 700 /root
sudo chown -R root:root /root/.ssh
# end root ssh setup

# begin user ssh setup
if [[ ! -e ~/.ssh/authorized_keys ]]; then
    echo "Creating authorized_keys file"
    touch ~/.ssh/authorized_keys
fi

if [[ ! -e ~/.ssh/authorized_keys.bak ]]; then
    echo "Backing up authorized_keys file."
    cp ~/.ssh/authorized_keys ~/.ssh/authorized_keys.bak
fi


# Check whether the key already exists in the authorized_keys file
key=$(awk '{print $2 }' node_ssh_rsa_key.pub)
res=$(cat ~/.ssh/authorized_keys | grep $key )
if [[ $res == "" ]]; then
    echo "Setting up ssh authorized keys."
    cat node_ssh_rsa_key.pub >> ~/.ssh/authorized_keys 
fi

sudo chmod -R 600 ~/.ssh
sudo chmod 700 ~/.ssh
# end user ssh setup

sudo service ssh restart

echo "ssh node setup complete..."

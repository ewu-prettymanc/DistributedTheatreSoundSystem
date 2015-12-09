#!/bin/bash

hostn=$(cat /etc/hostname)

echo "Current hostname is $hostn"

if [ "$#" -ne 1 ]; then
	echo "Usage: ./change_hostname new_hostname; WARNING NEEDS ROOT AND NEEDS REBOOT"
	exit 0
fi

newhost="$1"

sudo sed -i "s/$hostn/$newhost/g" /etc/hosts

sudo sed -i "s/$hostn/$newhost/g" /etc/hostname

echo "The Computer will reboot in 5 seconds."
sleep 5

sudo reboot

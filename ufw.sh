#!/bin/bash

# Check if user is root or sudo
if ! [ $( id -u ) = 0 ]; then
    echo "Please run this script as sudo or root" 1>&2
    exit 1
fi

# Update OS
sudo apt update -y

# Install UFW
sudo apt install ufw -y
sudo ufw disable && sudo ufw enable

# Secure UFW Firewall
sudo ufw default deny incoming

# Setup RDP For windows Remote Desktop
sudo ufw allow 3389
sudo ufw enable
#!/bin/bash
# Script to install Plex inside of a jail

SERVICE=plexmediaserver

# Check for your Plex jail
jls

# Connect to the Plex jail
jexec 1 tcsh

# Update packages
pkg update && pkg upgrade -y

# Install Plex
pkg install multimedia/plexmediaserver

# Set Plex to start automatically
sysrc plexmediaserver_enable=YES

# Start Plex
if (( $(ps -ef |grep -v grep | grep $SERVICE | wc -l) > 0 ))
then
    echo $SERVICE is running!"
else
    service $SERVICE start
fi


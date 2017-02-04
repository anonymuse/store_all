#!/bin/bash

# Create an SSH key for the Freenas root user
#
# -N "" tells the script to use an empty passphrase
# -f %KEYNAME% tells the script where to store the file
# yes "y" sends an enter style return to the prompts

yes "y" | ssh-keygen -t rsa -b 4096 -N "" -f $HOME/.ssh/freenas_id_rsa

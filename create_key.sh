#!/bin/bash

# Create an SSH key for the Freenas root user

yes "y" | ssh-keygen -t rsa -b 4096 -N "" -f $HOME/.ssh/freenas_id_rsa

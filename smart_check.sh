#!/bin/bash

# Hard Drive Burn-In Testing
# As seen here:
# https://forums.freenas.org/index.php?threads/how-to-hard-drive-burn-in-testing.21451/

# Isolate the available disks
camcontrol devlist

# Isolate the names of the disks

#TODO: extract the adax device
camcontrol devlist | awk '{print $10}'



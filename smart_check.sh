#!/bin/bash

# Hard Drive Burn-In Testing
# As seen here:
# https://forums.freenas.org/index.php?threads/how-to-hard-drive-burn-in-testing.21451/

# Isolate the available disks
camcontrol devlist

# Isolate the names of the disks

#TODO: extract the adax device
camcontrol devlist | awk '{print $10}'

# Run short tests
smartctl -t short /dev/ada0
smartctl -t short /dev/ada1
smartctl -t short /dev/ada2
smartctl -t short /dev/ada3
smartctl -t short /dev/ada4
smartctl -t short /dev/ada5

# Run conveyance tests
smartctl -t conveyance /dev/ada0
smartctl -t conveyance /dev/ada1
smartctl -t conveyance /dev/ada2
smartctl -t conveyance /dev/ada3
smartctl -t conveyance /dev/ada4
smartctl -t conveyance /dev/ada5

# Run long tests
smartctl -t long /dev/ada0
smartctl -t long /dev/ada1
smartctl -t long /dev/ada2
smartctl -t long /dev/ada3
smartctl -t long /dev/ada4
smartctl -t long /dev/ada5

# Enable kernel geoometry flags
sysctl kern.geom.debugflags=0x10

# Run the badblocks test
badblocks -b 4096 -ws /dev/ada0
badblocks -b 4096 -ws /dev/ada1
badblocks -b 4096 -ws /dev/ada2
badblocks -b 4096 -ws /dev/ada3
badblocks -b 4096 -ws /dev/ada4
badblocks -b 4096 -ws /dev/ada5

#!/bin/bash

# Set the name of the hard drive to be formatted
disk="/dev/sda"

# Check if the hard drive is mounted
if mountpoint -q $disk; then
  # Unmount the hard drive
  umount $disk
fi

# Delete all existing partitions on the hard drive
fdisk $disk << EOF
d
w
EOF

# Create a new partition on the hard drive
fdisk $disk << EOF
n
p
1

+100M
t
c
n
p
2


w
EOF

# Format the new partition with the ext4 filesystem
mkfs.ext4 $disk"1"
mkfs.ext4 $disk"2"

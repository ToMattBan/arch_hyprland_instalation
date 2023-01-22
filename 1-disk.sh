#!/bin/sh

echo "Exporting Disk for installation"
export disk=$(cat ./disk.txt)

echo "Formatting the partitions"
mkfs.vfat -F32 ${disk}1
mkfs.btrfs -f ${disk}2

echo "Mounting root"
mount ${disk}2 /mnt

echo "Creating subvolumes"
btrfs subvolume create /mnt/@
# Uncomment when wanting to use home as subvolume instead of another partition
# btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@srv
btrfs subvolume create /mnt/@pacman
btrfs subvolume create /mnt/@containers
btrfs subvolume create /mnt/@docker
btrfs subvolume create /mnt/@flatpak
btrfs subvolume create /mnt/@libvirt
btrfs subvolume create /mnt/@machines
btrfs subvolume create /mnt/@portables
btrfs subvolume create /mnt/@waydroid
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@snapshots

umount /mnt

echo "Done"


#!/bin/sh

echo "Installing snapper"
sudo pacman -Syu
sudo pacman -S --needed snapper

echo "Deleting snapshots folder"
sudo umount /.snapshots
sleep 1
sudo umount /.snapshots
sudo rm -rf /.snapshots
sleep 1
sudo rm -rf /.snapshots

echo "Creating config for root"
sudo snapper -c root create-config /

echo "Remounting snapshots subvolume"
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -a

echo "Setting Permissions"
sudo chmod 750 /.snapshots
sudo chown root:wheel /.snapshots

echo "First Snapshot"
sudo snapper -c root create -d "Base"

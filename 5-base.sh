#!/bin/sh

# Uncomment depending on your cpu
# export microcode="intel-ucode"
export microcode="amd-ucode"

# Kernel variant
export opt="-cachyos" ## "", "-zen", "-cachyos", "-xanmod", "-lts" etc. needs to be in repo

echo "Installing what I consider a base intall (needs additional repos to be enabled)"
pacstrap /mnt base base-devel linux${opt} linux-firmware ${microcode} paru pacman-contrib btrfs-progs dosfstools bash-completion man-db man-pages texinfo downgrade efibootmgr exfatprogs ntfs-3g nano-syntax-highlighting networkmanager pacman-contrib sudo xdg-user-dirs tmux htop zram-generator zip mc grub grub-btrfs efibootmgr update-grub

echo "Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

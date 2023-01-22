#!/bin/sh

echo "Backup pacman.conf"
sudo cp /etc/pacman.conf /etc/pacman.conf.bak

echo "Updating database"
pacman -Sy

echo "Adding repo keys"
pacman-key --recv-key F3B607488DB35A47 --keyserver keyserver.ubuntu.com
pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
pacman-key --lsign-key F3B607488DB35A47
pacman-key --lsign-key FBA220DFC880C036

echo "Installing repo files"
pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-2-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-14-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-14-1-any.pkg.tar.zst' 'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-6.0.2-10-x86_64.pkg.tar.zst'

echo "Downloading alcn mirrorlist"
curl 'https://raw.githubusercontent.com/archlinuxcn/mirrorlist-repo/master/archlinuxcn-mirrorlist' -o /etc/pacman.d/archlinuxcn-mirrorlist
sed -i '/Server/s/^# //g' /etc/pacman.d/archlinuxcn-mirrorlist

echo "Adding repos to pacman.conf"
sed -i '71i
71i[cachyos-v3]
71iInclude = /etc/pacman.d/cachyos-v3-mirrorlist
71i
71i[cachyos]
71iInclude = /etc/pacman.d/cachyos-mirrorlist' /etc/pacman.conf

echo '' >> /etc/pacman.conf
echo '[archlinuxcn]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/archlinuxcn-mirrorlist/' >> /etc/pacman.conf
echo '' >> /etc/pacman.conf
echo '[chaotic-aur]' >> /etc/pacman.conf
echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf

echo "Installing alcn keyring"
pacman -Sy --noconfirm archlinuxcn-keyring

echo "After doing this in chroot stage, uncomment multilib repo in /etc/pacman.conf"

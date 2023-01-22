#!/bin/sh

echo "Exporting disk for use in install/repair"
export disk="/dev/sda"
export sv_opts="rw,noatime,compress-force=zstd:1,space_cache=v2"

echo "Mounting root"
mount -o ${sv_opts},subvol=@ ${disk}2 /mnt

echo "Creating subdirs"
mkdir -p /mnt/{boot/efi,home,root,srv,.snapshots,var/cache/pacman,var/lib/containers,var/lib/docker,var/lib/flatpak,var/lib/libvirt,var/lib/machines,var/lib/portables,var/lib/waydroid,var/log,var/tmp}

echo "Mounting Subvolumes"
mount ${disk}1 /mnt/boot/efi
mount -o ${sv_opts},subvol=@root ${disk}2 /mnt/root
mount -o ${sv_opts},subvol=@srv ${disk}2 /mnt/srv
mount -o ${sv_opts},subvol=@pacman ${disk}2 /mnt/var/cache/pacman
mount -o ${sv_opts},subvol=@containers ${disk}2 /mnt/var/lib/containers
mount -o ${sv_opts},subvol=@docker ${disk}2 /mnt/var/lib/docker
mount -o ${sv_opts},subvol=@flatpak ${disk}2 /mnt/var/lib/flatpak
mount -o ${sv_opts},subvol=@libvirt ${disk}2 /mnt/var/lib/libvirt
mount -o ${sv_opts},subvol=@machines ${disk}2 /mnt/var/lib/machines
mount -o ${sv_opts},subvol=@portables ${disk}2 /mnt/var/lib/portables
mount -o ${sv_opts},subvol=@waydroid ${disk}2 /mnt/var/lib/waydroid
mount -o ${sv_opts},subvol=@log ${disk}2 /mnt/var/log
mount -o ${sv_opts},subvol=@tmp ${disk}2 /mnt/var/tmp
mount -o ${sv_opts},subvol=@snapshots ${disk}2 /mnt/.snapshots

# Uncomment when using home subvolume
#mount -o ${sv_opts},subvol=@home ${disk}2 /mnt/home

# Uncomment when using home in other partition
mount ${disk}3 /mnt/home

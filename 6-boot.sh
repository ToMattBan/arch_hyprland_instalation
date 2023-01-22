#!/bin/sh

echo "Exporting EFI partition mount point"
export efidr="/boot/efi"

echo "Updating database"
pacman -Sy

echo "Grub install"
pacman -S --needed grub grub-btrfs efibootmgr update-grub os-prober

grub-install --target=x86_64-efi --efi-directory=${efidr} --bootloader-id=Arch

grub-mkconfig -o /boot/grub/grub.cfg

echo "Enabling Grub-btrfs hook"
sed -i 's/MODULES=()/MODULES=(btrfs)/g' /etc/mkinitcpio.conf
sed -i 's/HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block filesystems fsck grub-btrfs-overlayfs)/g' /etc/mkinitcpio.conf

mkinitcpio -P

echo "Enabling Grub btrfs service"
systemctl enable grub-btrfs.path

echo "Enabling Fstrim"
systemctl enable fstrim.timer

# Some notes first:
# It's recommended to use tmux for ease of reading while using the scripts, cheat sheet here https://tmuxcheatsheet.com/
# Don't forget to uncomment multilib after adding the repos with script 4
# In script 7 you might need to cd or change the path of ./user-paths to match this folder location
# In script 9 Same as above, ^ or ^ of ./package_list.txt to match this folder location
# There's also a issue with 8, not working when run from script, but typing each command mannualy works

Installation

Format disk:
1-disk.sh - DON'T RUN WITHOUT CHECKING FIRST, IT WILL FORMAT THE DEVICE AND CREATE SUBVOLUMES

Mount partitions:
2-mount.sh - Will mount all btrfs subvolumes and optionally an external home partition, change as needed

Set locales:
3-locale.sh - Set your language, change as needed

Enable additional repos:
4-repos.sh - Will enabled additional repos, CachyOS, Chaotic AUR and ArchlinuxCN 

Install base system:
5-base.sh - Will install base system and some additional packages

Now chroot to your installation:
arch-chroot /mnt 

Set your locales for the install:
3-locale.sh - Now for your installed system instead of live environment

Enable repos for installed system:
4-repos.sh - Now for your installed system instead of live environment

Install bootloader:
6-boot.sh - Will install grub and configure mkinitcpio modules/hooks for early KMS and grub-btrfs, change accordingly to GPU

Prepare user environment:
7-user.sh - Create user and set passwords, also define some system variables

Unmount and reboot:
exit
umount -R /mnt
reboot - It's needed to reboot since some apps in the package list are AUR only for now so paru needs to be runned as user instead of root

Login in to your user

Set snapper and snapshot:
8-snapper.sh - Will install and configure snapper also will do the first snapshot

Install Hyprland:
9-hypr.sh - Will install hyprland with some apps and will generate start script


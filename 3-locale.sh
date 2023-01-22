#!/bin/sh

echo "Export locale"
export LANG=pt_BR.UTF-8
export locale="pt_BR.UTF-8"
export keymap="br-abnt2"
export timezone="America/Sao_Paulo"

echo "Set locales"
loadkeys ${keymap}
sed -i "s/^#\(${locale}\)/\1/" /etc/locale.gen
echo "LANG=${locale}" > /etc/locale.conf
echo "KEYMAP=${keymap}" > /etc/vconsole.conf
ln -sf /usr/share/zoneinfo/${timezone} /etc/localtime
hwclock --systohc
locale-gen
echo "Ignore this error when chrooted"
timedatectl set-ntp true
timedatectl status

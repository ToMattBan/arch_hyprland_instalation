echo "Exporting user vars"
# Machine name
export host="arch"
# Your editor
export edit="nano"
# Your username
export user="k"
#!/bin/sh

echo "Setting host"
echo ${host} > /etc/hostname
cat > /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   ${host}.localdomain ${host}
EOF

echo "Settings some vars"
echo EDITOR=${edit} >> /etc/environment 
echo VISUAL=${edit} >> /etc/environment

echo "Copying user-paths.sh"
sudo cp ./user-paths.sh /etc/profile.d/user-paths.sh
sudo chmod +x /etc/profile.d/user-paths.sh

echo "Set root password"
passwd root

echo "Adding user"
useradd -m -G wheel ${user}
echo "Set user password"
passwd ${user}

echo "Activating wheel group"
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel-10
# Actv. wheel alternative
## sed -i "s/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/" /etc/sudoers

echo "Enabling NetworkManager"
systemctl enable NetworkManager

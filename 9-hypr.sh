#!/bin/sh

export user="k"

echo "Installing Hyprland-DE"
paru -S `cat package_list.txt`

echo "Removing xdg-desktop-portal-wlr (it's a makedep for Hypr desktop portal but causes conflict)"
paru -R xdg-desktop-portal-wlr

echo "Generating session script"
mkdir -p /home/${user}/.local/bin

cat > /home/${user}/.local/bin/wraphl <<EOF
#!/bin/sh

cd ~

export _JAVA_AWT_WM_NONREPARENTING=1
#export TERM=foot
#export GTK_THEME="Qogir-Dark"
#export XCURSOR_THEME="Qogir-dark"
export XCURSOR_SIZE=24
export XDG_CURRENT_DESKTOP="Hyprland"
export XDG_SESSION_TYPE="wayland"
export XDG_SESSION_DESKTOP="Hyprland"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM="xcb;wayland"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export CLUTTER_BACKEND="wayland"
export GDK_BACKEND="wayland,x11"
export MOZ_ENABLE_WAYLAND=1
#Nvidia - Needs additional work, more info at https://wiki.hyprland.org/Nvidia/
#export LIBVA_DRIVER_NAME=nvidia
#export XDG_SESSION_TYPE=wayland
#export GBM_BACKEND=nvidia-drm
#export __GLX_VENDOR_LIBRARY_NAME=nvidia
#export WLR_NO_HARDWARE_CURSORS=1

exec Hyprland
EOF

chmod +x /home/${user}/.local/bin/wraphl

cat > /home/${user}/hyprland-${user}.desktop <<EOF
[Desktop Entry]
Name=Hyprland (${user})
Comment=An intelligent dynamic tiling Wayland compositor (wrapped)
Exec=/home/${user}/.local/bin/wraphl
Type=Application
EOF

sudo mv /home/${user}/hyprland-${user}.desktop /usr/share/wayland-sessions/hyprland-{user}.desktop

echo "Enabling SDDM"
systemctl enable sddm

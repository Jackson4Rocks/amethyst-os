#!/bin/bash

set -euo pipefail

###############################################################################
# AMETHYST OS AURORA
# Live environment customization
###############################################################################

echo "==> Configuring Amethyst OS AURORA live environment..."

###############################################################################
# BASIC DIRECTORIES
###############################################################################

install -d -m 0755 /etc/sudoers.d
install -d -m 0755 /etc/sddm.conf.d
install -d -m 0755 /usr/share/backgrounds/amethyst
install -d -m 0755 /usr/local/bin
install -d -m 0755 /usr/share/applications

###############################################################################
# AMETHYST OS IDENTITY
###############################################################################

echo "==> Setting Amethyst OS identity..."

cat > /usr/lib/os-release <<'EOF'
NAME="Amethyst OS"
ID=amethyst
ID_LIKE=arch
PRETTY_NAME="Amethyst OS AURORA"
VERSION="AURORA"
VERSION_ID="0.1"
VERSION_CODENAME="aurora"
HOME_URL="https://github.com/Jackson4Rocks/amethyst-os"
SUPPORT_URL="https://github.com/Jackson4Rocks/amethyst-os/issues"
BUG_REPORT_URL="https://github.com/Jackson4Rocks/amethyst-os/issues"
EOF

rm -f /etc/os-release
ln -s ../usr/lib/os-release /etc/os-release

###############################################################################
# AMETHYST LIVE USER
###############################################################################

echo "==> Creating/configuring amethyst user..."

if ! id -u amethyst >/dev/null 2>&1; then
    useradd \
        --create-home \
        --shell /usr/bin/zsh \
        --groups wheel \
        amethyst
fi

# Always enforce the desired shell and group membership.
usermod --shell /usr/bin/zsh amethyst
usermod --append --groups wheel amethyst

# Make sure the home directory exists.
install -d -m 0755 -o amethyst -g amethyst /home/amethyst

###############################################################################
# PASSWORDLESS SUDO FOR LIVE SESSION
###############################################################################

echo "==> Configuring sudo..."

cat > /etc/sudoers.d/amethyst <<'EOF'
amethyst ALL=(ALL) NOPASSWD: ALL
EOF

chmod 0440 /etc/sudoers.d/amethyst

###############################################################################
# COPY /etc/skel INTO LIVE USER'S HOME
###############################################################################

echo "==> Installing Amethyst user configuration..."

if [ -d /etc/skel ]; then
    cp -a /etc/skel/. /home/amethyst/
fi

chown -R amethyst:amethyst /home/amethyst


# Enable AOS live welcome service for the live user
install -d -m 0755 /home/amethyst/.config/systemd/user

if [ -f /etc/skel/.config/systemd/user/aos-live-welcome.service ]; then
    cp -f \
        /etc/skel/.config/systemd/user/aos-live-welcome.service \
        /home/amethyst/.config/systemd/user/aos-live-welcome.service

    chown amethyst:amethyst \
        /home/amethyst/.config/systemd/user/aos-live-welcome.service
fi

mkdir -p /home/amethyst/.config/systemd/user/default.target.wants

ln -sf \
    ../aos-live-welcome.service \
    /home/amethyst/.config/systemd/user/default.target.wants/aos-live-welcome.service

chown -R amethyst:amethyst /home/amethyst/.config/systemd


###############################################################################
# ZSH
###############################################################################

echo "==> Configuring Zsh..."

if [ -f /etc/skel/.zshrc ]; then
    cp -f /etc/skel/.zshrc /home/amethyst/.zshrc
    chown amethyst:amethyst /home/amethyst/.zshrc
fi

###############################################################################
# FASTFETCH
###############################################################################

echo "==> Configuring Fastfetch..."

if [ -d /etc/skel/.config/fastfetch ]; then
    install -d -m 0755 /home/amethyst/.config
    cp -a /etc/skel/.config/fastfetch /home/amethyst/.config/
    chown -R amethyst:amethyst /home/amethyst/.config/fastfetch
fi

###############################################################################
# HYPRLAND
###############################################################################

echo "==> Configuring Hyprland..."

if [ -d /etc/skel/.config/hypr ]; then
    install -d -m 0755 /home/amethyst/.config
    cp -a /etc/skel/.config/hypr /home/amethyst/.config/
    chown -R amethyst:amethyst /home/amethyst/.config/hypr
fi

###############################################################################
# HYPRPAPER
###############################################################################

echo "==> Configuring Hyprpaper..."

if [ -f /etc/skel/.config/hypr/hyprpaper.conf ]; then
    chmod 0644 /home/amethyst/.config/hypr/hyprpaper.conf
fi

###############################################################################
# AURORA WALLPAPER
###############################################################################

echo "==> Checking AURORA wallpaper..."

if [ -f /usr/share/backgrounds/amethyst/AURORA-16x9.png ]; then
    chmod 0644 /usr/share/backgrounds/amethyst/AURORA-16x9.png
else
    echo "WARNING: AURORA-16x9.png was not found."
fi

###############################################################################
# SDDM
###############################################################################

echo "==> Configuring SDDM..."

cat > /etc/sddm.conf.d/amethyst.conf <<'EOF'
[General]
DisplayServer=wayland

[Autologin]
User=amethyst
Session=hyprland.desktop
Relogin=false
EOF

chmod 0644 /etc/sddm.conf.d/amethyst.conf

###############################################################################
# NETWORKMANAGER
###############################################################################

echo "==> Enabling NetworkManager..."

systemctl enable NetworkManager.service 2>/dev/null || true

###############################################################################
# SDDM SERVICE
###############################################################################

echo "==> Enabling SDDM..."

systemctl enable sddm.service 2>/dev/null || true

###############################################################################
# POWER PROFILES
###############################################################################

if command -v systemctl >/dev/null 2>&1; then
    systemctl enable power-profiles-daemon.service 2>/dev/null || true
fi

###############################################################################
# POLKIT
###############################################################################

echo "==> Preparing Polkit..."

if [ -x /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 ]; then
    install -d -m 0755 /etc/xdg/autostart

    cat > /etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop <<'EOF'
[Desktop Entry]
Name=Polkit Authentication Agent
Comment=Authentication Agent
Exec=/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
Terminal=false
Type=Application
NoDisplay=true
X-GNOME-Autostart-Phase=Initialization
EOF

    chmod 0644 /etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop
fi

###############################################################################
# AOS INSTALLER
###############################################################################

echo "==> Checking AOS installer..."

if [ -f /usr/local/bin/aos-installer ]; then
    chmod 0755 /usr/local/bin/aos-installer
fi

if [ -f /usr/local/bin/aos-live-welcome ]; then
    chmod 0755 /usr/local/bin/aos-live-welcome
fi

###############################################################################
# DESKTOP ENTRY
###############################################################################

if [ -f /usr/share/applications/amethyst-installer.desktop ]; then
    chmod 0644 /usr/share/applications/amethyst-installer.desktop
fi

###############################################################################
# LIVE USER ENVIRONMENT
###############################################################################

cat > /home/amethyst/.profile <<'EOF'
# Amethyst OS AURORA environment

export AOS_NAME="Amethyst OS"
export AOS_CODENAME="AURORA"

# Prefer Wayland.
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland,x11
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
EOF

chown amethyst:amethyst /home/amethyst/.profile
chmod 0644 /home/amethyst/.profile

###############################################################################
# ZSH ENVIRONMENT
###############################################################################

cat > /home/amethyst/.zshenv <<'EOF'
export AOS_NAME="Amethyst OS"
export AOS_CODENAME="AURORA"
EOF

chown amethyst:amethyst /home/amethyst/.zshenv
chmod 0644 /home/amethyst/.zshenv

###############################################################################
# REMOVE LEFTOVER CALAMARES CONFIGURATION
###############################################################################

if [ -d /etc/calamares ]; then
    echo "==> Removing leftover Calamares configuration..."
    rm -rf /etc/calamares
fi

###############################################################################
# PERMISSIONS
###############################################################################

chown -R amethyst:amethyst /home/amethyst

chmod 0755 /home/amethyst
chmod 0700 /home/amethyst/.config 2>/dev/null || true

###############################################################################
# FINAL CHECKS
###############################################################################

echo
echo "============================================================"
echo "             AMETHYST OS AURORA READY"
echo "============================================================"

echo "User : $(id -un amethyst)"
echo "Shell: $(getent passwd amethyst | cut -d: -f7)"

if command -v fastfetch >/dev/null 2>&1; then
    echo "Fastfetch: installed"
fi

if command -v zsh >/dev/null 2>&1; then
    echo "Zsh      : installed"
fi

if command -v hyprland >/dev/null 2>&1; then
    echo "Hyprland : installed"
fi

if [ -f /usr/share/backgrounds/amethyst/AURORA-16x9.png ]; then
    echo "Wallpaper: installed"
fi

echo "============================================================"

###############################################################################
# IMPORTANT:
# Do NOT manually unmount /etc/resolv.conf here.
# Archiso handles the build/chroot mounts itself.
###############################################################################

exit 0

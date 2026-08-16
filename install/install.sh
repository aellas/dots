#!/usr/bin/env bash
set -euo pipefail

echo "=== Fedora Minimal Installation Script ==="
echo "Running as: $(whoami)"

# ─── Initial Setup ───────────────────────────────────────────────────────────
echo ">> Updating system..."
sudo dnf update --refresh

echo ">> Installing base packages..."
sudo dnf install -y \
    git bspwm sxhkd picom polybar rofi zsh \
    bat eza zoxide fastfetch maim nitrogen \
    feh xrandr lxpolkit dunst xsecurelock \
    udiskie brightnessctl

# ─── ZSH Plugins ─────────────────────────────────────────────────────────────
export ZSH_CUSTOM="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"

git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"

git clone https://github.com/fdellwing/zsh-bat.git \
    "${ZSH_CUSTOM}/plugins/zsh-bat"

# ─── Nix ─────────────────────────────────────────────────────────────────────
echo ">> Installing Nix..."
sudo dnf install -y nix nix-daemon

mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# ─── Home Manager ────────────────────────────────────────────────────────────
echo ">> Cloning dotfiles and running Home Manager..."
git clone https://codeberg.org/lxde/dots.git ~/nux
cd ~/nux
nix run github:nix-community/home-manager -- switch --flake .

# ─── Doom Emacs ──────────────────────────────────────────────────────────────
echo ">> Installing Doom Emacs..."
git clone --depth 1 https://github.com/doomemacs/core ~/.config/emacs
~/.config/emacs/bin/doom install
sudo rm -rf ~/.emacs.d

# ─── X11 Touchpad ────────────────────────────────────────────────────────────
echo ">> Configuring touchpad (natural scrolling + tapping)..."
sudo tee /etc/X11/xorg.conf.d/30-touchpad.conf > /dev/null <<'EOF'
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "NaturalScrolling" "true"
EndSection
EOF

# ─── TrackPoint ──────────────────────────────────────────────────────────────
echo ">> Setting up TrackPoint fix..."
sudo tee /etc/systemd/system/disable-trackpoint.service <<'EOF' > /dev/null
[Unit]
Description=Disable TrackPoint sensitivity, keep buttons
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo 0 > /sys/devices/platform/i8042/serio1/sensitivity'

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable disable-trackpoint.service
sudo systemctl start disable-trackpoint.service

# ─── RPM Fusion + Multimedia ────────────────────────────────────────────────
echo ">> Enabling RPM Fusion and installing multimedia packages..."
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y \
    @multimedia --setopt="install_weak_deps=False" \
    --exclude=PackageKit-gstreamer-plugin

sudo dnf install -y intel-media-driver
sudo dnf install -y rpmfusion-nonfree-release-tainted

# ─── XLibre ────────────────────────────────────────────────────────────────
echo ">> Enabling XLibre COPR and installing..."
sudo dnf copr enable -y @xlibre/xlibre-xserver
sudo dnf install -y xlibre-xserver xlibre-xf86-input-libinput --allowerasing

# ─── Librewolf ──────────────────────────────────────────────────────────────
echo ">> Enabling Librewolf repo and installing..."
sudo dnf config-manager --add-repo https://repo.librewolf.net/librewolf.repo
sudo dnf install -y librewolf

# ─── Tailscale ──────────────────────────────────────────────────────────────
echo ">> Installing Tailscale..."
sudo dnf install -y tailscale
sudo systemctl enable --now tailscaled
sudo tailscale up

# ─── Fonts ──────────────────────────────────────────────────────────────────
echo ">> Installing custom fonts..."
mkdir -p ~/.fonts
cp -r ~/nux/home/config/fonts/* ~/.fonts/
fc-cache -f

# ─── Steam ──────────────────────────────────────────────────────────────────
echo ">> Installing Steam..."
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf update --refresh
sudo dnf install -y steam

# ─── Gesture Support ────────────────────────────────────────────────────────
echo ">> Installing Touchegg..."
sudo dnf install -y touchegg

echo ""
echo "=== Installation complete! ==="

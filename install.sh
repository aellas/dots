#!/usr/bin/env bash
set -euo pipefail

# ─── Fedora install script for the lxde/dots repository ───
# Usage: bash install.sh

# Update the system
echo "=== Updating system ==="
sudo dnf upgrade -y

# Install nix and dependencies
echo "=== Installing nix and dependencies ==="
sudo dnf install -y git coreutils curl tar nix

# Clone the repository if not already present
if [ ! -d "$(pwd)/nix" ]; then
    git clone https://codeberg.org/lxde/dots.git . 2>/dev/null || {
        echo "Failed to clone the repository."
        exit 1
    }
fi

# Enter the repository directory
cd "$(pwd)" || exit 1

# Update flakes
echo "=== Updating flakes ==="
flake update

# Apply home-manager config
echo "=== Applying home-manager configuration ==="
nix-env home-manager --apply

echo "=== Install complete ==="
echo "Restart your system for changes to take effect."
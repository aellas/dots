#!/bin/bash

host=$(hostname)
dotfiles_dir="/home/array/Documents/GitHub/dots"

options="Rebuild
Upgrade 
Garbage Collect
Exit"

choice=$(echo -e "$options" | rofi -dmenu -p "NixOS Manager")

cd "$dotfiles_dir" || { echo "Failed to cd to $dotfiles_dir"; exit 1; }

case "$choice" in
    "Rebuild")
        echo "Rebuilding NixOS system configuration..."
        sudo nixos-rebuild switch --flake .#"$host"
        ;;
    "Upgrade")
        echo "Upgrading NixOS system configuration..."
        sudo nixos-rebuild switch --upgrade --flake .#"$host"
        ;;
   "Garbage Collect System (sudo)")
        echo "Running garbage collection on system profiles older than 15 days..."
        sudo nix-collect-garbage --max-age 15d && nix-collect-garbage --max-age 15d
        ;;
    "Exit")
        exit 0
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

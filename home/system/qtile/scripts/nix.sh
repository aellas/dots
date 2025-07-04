#!/usr/bin/env bash

set -e

FLAKE_DIR="/home/array/Documents/nixos/main"

CHOICE=$(printf "ra (arynix)\nrx (xpsnix)\nrt (thinknix)\nuf (flake update)" | rofi -dmenu -p "NixOS Action")

cd "$FLAKE_DIR"

case "$CHOICE" in
  "ra (arynix)")
    exec sudo nixos-rebuild switch --flake .#arynix
    ;;
  "rx (xpsnix)")
    exec sudo nixos-rebuild switch --flake .#xpsnix
    ;;
  "rt (thinknix)")
    exec sudo nixos-rebuild switch --flake .#thinknix
    ;;
  "uf (flake update)")
    exec nix flake update
    ;;
  *)
    notify-send "NixOS Rofi" "No valid selection made."
    exit 1
    ;;
esac

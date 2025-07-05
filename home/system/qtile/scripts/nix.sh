#!/usr/bin/env bash

set -e

FLAKE_DIR="/home/array/Documents/nixos/main"

MENU_OPTIONS=(
  "\nSelect a NixOS Action:"
  "arynix (Rebuild)"
  "xpsnix (Rebuild)"
  "thinknix (Rebuild)"
  "update (Flake)"
  "show (Flake)"
  "Exit" # Added an explicit exit option
)

echo "${MENU_OPTIONS[0]}" # Print the instruction

# Display the numbered menu and prompt for choice
select CHOICE in "${MENU_OPTIONS[@]:1}"; do
  case "$CHOICE" in
    "arynix (Rebuild)")
      echo "Rebuilding arynix..."
      cd "$FLAKE_DIR"
      exec sudo nixos-rebuild switch --flake .#arynix
      ;;
    "xpsnix (Rebuild)")
      echo "Rebuilding xpsnix..."
      cd "$FLAKE_DIR"
      exec sudo nixos-rebuild switch --flake .#xpsnix
      ;;
    "thinknix (Rebuild)")
      echo "Rebuilding thinknix..."
      cd "$FLAKE_DIR"
      exec sudo nixos-rebuild switch --flake .#thinknix
      ;;
    "update (Flake)")
      echo "Updating flake..."
      cd "$FLAKE_DIR"
      exec nix flake update
      ;;
    "show (Flake)")
      echo "Showing flake info..."
      cd "$FLAKE_DIR"
      exec nix flake show
      ;;
    "Exit")
      echo "Exiting."
      exit 0
      ;;
    *)
      echo "Invalid selection. Please try again."
      # This causes the select loop to continue
      ;;
  esac
done
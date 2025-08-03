#!/usr/bin/env bash

# === DEFAULTS ===
DEFAULT_HOSTNAME="$(hostname)"
FLAKE_DIR="/home/array/Documents/nixos/main/"  # Change if your flake lives elsewhere

# === FUNCTIONS ===

print_menu() {
  echo "ᴠᴇʀʏ ᴄᴏᴏʟ ɴɪx ᴛʜɪɴɢ"
  echo ""
  echo "Detected [ $DEFAULT_HOSTNAME ]"
  echo
  echo "Choose an action:"
  echo "1) nix flake update"
  echo "2) nixos-rebuild switch & pray"
  echo "3) nixos-rebuild build"
  echo "5) Confirm hostname"
  echo "6) Override hostname"
  echo "q) Quit"
  echo
  read -rp "Enter choice: " CHOICE
}

run_action() {
  case "$CHOICE" in
    1)
      echo "Running: nix flake update $FLAKE_DIR"
      cd "$FLAKE_DIR" && nix flake update 
      ;;
    2)
      echo "Running: sudo nixos-rebuild switch --flake $FLAKE_DIR#$ACTIVE_HOSTNAME"
       sudo nixos-rebuild switch --flake "$FLAKE_DIR#$ACTIVE_HOSTNAME"      ;;
    3)
      echo "Running: sudo nixos-rebuild build --flake $FLAKE_DIR#$ACTIVE_HOSTNAME"
      sudo nixos-rebuild build --flake "$FLAKE_DIR#$ACTIVE_HOSTNAME"
      ;;
    4)
      echo "Running: sudo nixos-rebuild boot --flake $FLAKE_DIR#$ACTIVE_HOSTNAME"
      sudo nixos-rebuild boot --flake "$FLAKE_DIR#$ACTIVE_HOSTNAME"
      ;;
    5)
      echo "Current system hostname: $(hostname)"
      ;;
    6)
      read -rp "Enter override hostname: " CUSTOM_HOSTNAME
      ACTIVE_HOSTNAME="$CUSTOM_HOSTNAME"
      echo "✅ Using overridden hostname: $ACTIVE_HOSTNAME"
      ;;
    q|Q)
      echo "Exiting."
      exit 0
      ;;
    *)
      echo "Invalid choice."
      ;;
  esac
}

# === MAIN LOOP ===

ACTIVE_HOSTNAME="$DEFAULT_HOSTNAME"

while true; do
  print_menu
  run_action
  echo
  read -rp "Press enter to continue..."
  clear
done

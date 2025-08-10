{ pkgs, ... }: {
  home.packages = with pkgs; [
  ];

  home.file.".config/qtile/scripts/screenshot.sh" = {
    text = ''
#!/usr/bin/env bash

options="󰹑  Fullscreen\n󰨵  Region"
choice=$(echo -e "$options" | rofi -dmenu -p "Screenshot")

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
filename="screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
filepath="$DIR/$filename"

case "$choice" in
    "󰹑  Fullscreen")
        grim "$filepath" && wl-copy < "$filepath"
        notify-send "Screenshot saved" "$filepath"
        ;;

    "󰨵  Region")
        geom=$(slurp)
        if [ -z "$geom" ]; then
          notify-send "Screenshot cancelled"
          exit 1
        fi
        grim -g "$geom" "$filepath" && wl-copy < "$filepath"
        notify-send "Screenshot (selection) saved" "$filepath"
        ;;

    *)
        exit 1
        ;;
esac

    '';
    executable = true;  # This makes the script executable
  };
}

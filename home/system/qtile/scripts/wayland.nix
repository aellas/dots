{pkgs, ...}: {
  home.packages = with pkgs; [
 ];

  home.file.".config/qtile/scripts/wayland.sh" = {
    text = ''
    #!/usr/bin/env bash

wl-copy &
waypaper --restore &
way-displays &
    '';
    executable = true;  # This makes the script executable
  };

}

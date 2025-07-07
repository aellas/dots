{ pkgs, ... }:
{
    programs = {
      hyprland = {
        enable = true;
      };
      xwayland = {
        enable = true;
      };
    };

    environment.systemPackages = with pkgs; [   
        xwayland
        pamixer
        swaybg
        hyprpicker
        power-profiles-daemon
   ];
}
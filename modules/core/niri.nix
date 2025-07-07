{ pkgs, ... }:
{
    programs.niri = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [   
        niri
        xwayland-satellite
        dunst
        polkit_gnome
        swayidle
        swaybg
   ];
}
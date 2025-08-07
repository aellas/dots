{ config, pkgs, inputs, ... }:
{
  home.username = "array";
  home.homeDirectory = "/home/array";

  programs.home-manager.enable = true;
  systemd.user.startServices = true;

  imports = [

    # Programs 
    ./programs/default.nix

    ./system/qtile.nix
    ./system/way-displays.nix
    ./system/dunst.nix
 ];

  home.stateVersion = "25.11";
}

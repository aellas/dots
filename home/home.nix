{ config, pkgs, inputs, ... }:
{
  home.username = "array";
  home.homeDirectory = "/home/array";

  programs.home-manager.enable = true;
  systemd.user.startServices = true;

  imports = [
    # Programs 
    ./programs/default.nix
    ./programs/doom/doom.nix
    ./programs/doom/extra.nix

    ./system/qtile.nix
    ./system/way-displays.nix
    ./system/dunst.nix
    ./system/gtk.nix
 ];

  home.stateVersion = "25.11";
}

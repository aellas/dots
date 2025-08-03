{ config, pkgs, inputs, ... }:
{
  home.username = "array";
  home.homeDirectory = "/home/array";

  programs.home-manager.enable = true;

  imports = [
    ./programs/kitty.nix
    ./programs/ghostty.nix
    ./programs/neovim.nix
    ./programs/fastfetch/default.nix
    ./programs/nixcord.nix
    ./programs/yazi/default.nix
    ./programs/rofi.nix
    ./programs/firefox.nix
    ./programs/git.nix
    ./programs/fzf.nix

    ./programs/emacs.nix
    
    ./system/qtile.nix
    ./system/mpd.nix
    ./system/way-displays.nix
 ];

  home.stateVersion = "25.11";
}

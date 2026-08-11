{ config, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nux/home/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    doom = "doom";
    fastfetch = "fastfetch";
    bspwm = "bspwm";
    polybar = "polybar";
    sxhkd = "sxhkd";
    rofi = "rofi";
    dunst = "dunst";
    picom = "picom";
    touchegg = "touchegg";
  };

  homeConfigs = {
    ".Xresources" = ".Xresources";
  };
in
{
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.file = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) homeConfigs;
}

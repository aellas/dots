{ pkgs, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "BreezeX-RoséPineDawn";
      package = pkgs.rose-pine-cursor;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "BreezeX-RoséPineDawn";
    };
  };
}
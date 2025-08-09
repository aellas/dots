{ pkgs, ... }:

{   
    gtk = {
    enable = true;
    theme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-theme;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    
    };
  };
    dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Qogir-Dark";
      icon-theme = "Papirus";
    };
  };
}
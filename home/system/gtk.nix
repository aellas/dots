{ pkgs, ... }:

{   
    gtk = {
    enable = true;
    theme = {
      name = "Graphite-Light";
      package = pkgs.graphite-gtk-theme;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    
    };
  };
    dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-light";
      gtk-theme = "Graphite-Light";
      icon-theme = "Papirus";
    };
  };
}
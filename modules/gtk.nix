{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "WhiteSur-Light";
      package = pkgs.whitesur-gtk-theme;
    };

    iconTheme = {
      name = "Paprius";
      package = pkgs.whitesur-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 32;
    };

  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "default";
      gtk-theme = "WhiteSur-Light";
      icon-theme = "Paprius";
    };
  };

  home.packages = with pkgs; [
    whitesur-gtk-theme
    gnome-themes-extra
    papirus-icon-theme
  ];
}

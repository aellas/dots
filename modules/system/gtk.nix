{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Fluent-Light";
      package = pkgs.fluent-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
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
      size = 52;
    };

  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "default";
      gtk-theme = "Fluent-Light";
      icon-theme = "Papirus-Dark";
    };
  };

  home.packages = with pkgs; [
    gnome-themes-extra
    lxappearance
  ];
}

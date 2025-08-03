{pkgs, ...}: {
  home.packages = with pkgs; [

      dunst
      pavucontrol
      pulseaudio
      pamixer
      alsa-utils
      playerctl
      polkit_gnome
      brightnessctl
      psmisc

      swaybg
      wl-clipboard
      wlr-randr
      grim
      slurp
      wl-color-picker
      libnotify
      waypaper
      way-displays
 ];

  home.file = {
    ".config/qtile" = {
      source = ./qtile;
      recursive = true;
    };
  };
}

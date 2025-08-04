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
      grim
      slurp
      wl-color-picker
      libnotify
      waypaper
      wdisplays
 ];

  home.file = {
    ".config/qtile" = {
      source = ./qtile;
      recursive = true;
    };
  };
}

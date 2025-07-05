{pkgs, ...}: {
  home.packages = with pkgs; [
      pywal16
      dunst
      feh
      pavucontrol
      pulseaudio
      pamixer
      alsa-utils
      playerctl
      git
      polkit_gnome
      picom
      xclip
      haskellPackages.greenclip
      gpick
      brightnessctl
      psmisc

      swaybg
      wl-clipboard
      wlr-randr
      grim
      slurp
  ];

  home.file = {
    ".config/qtile" = {
      source = ./qtile;
      recursive = true;
    };
  };
}

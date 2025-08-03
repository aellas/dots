{ profiles, pkgs, nixpkgs-unstable, ...}:
{
services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages: with python3Packages; [
      qtile-extras
      iwlib
    ];
  };

        environment.systemPackages = with pkgs; [
      dunst
      feh
      pavucontrol
      pulseaudio
      pamixer
      alsa-utils
      playerctl
      polkit_gnome
      picom
      xclip
      haskellPackages.greenclip
      gpick
      brightnessctl
      psmisc
      #pywalfox

      swaybg
      wl-clipboard
      wlr-randr
      grim
      slurp
      wl-color-picker
      libnotify
      waypaper

      nwg-look
      imagemagick
      libinput-gestures
    ];
}
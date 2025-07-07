{pkgs, ...}: {
  home.packages = with pkgs; [
    niri
    xwayland-satellite
    dunst
    polkit_gnome
    swayidle
    swaybg
    mako
  ];

  home.file = {
    ".config/niri" = {
      source = ./niri;
      recursive = true;
    };
  };
}

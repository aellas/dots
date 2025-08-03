{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
      github-desktop
      youtube-music
      vscodium
      flameshot
      nwg-look
      imagemagick
      protonvpn-gui
    ];
}

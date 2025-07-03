{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
      bolt-launcher
      github-desktop
      youtube-music
      vscodium
      flameshot
      nwg-look
      imagemagick
      protonvpn-gui
    ];
}

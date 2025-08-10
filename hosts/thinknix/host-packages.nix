{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
      github-desktop
      youtube-music
      vscodium
      protonvpn-gui
      wiremix
      gtk-frdp
      parsec-bin
  ];
}

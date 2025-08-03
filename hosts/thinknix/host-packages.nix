{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
      bolt-launcher
      github-desktop
      youtube-music
      vscodium
      protonvpn-gui
      wiremix
      gtk-frdp
      ventoy-full-gtk
      parsec-bin

    ];

  nixpkgs.config.permittedInsecurePackages = [
   "ventoy-gtk3-1.1.05"
  ];
}

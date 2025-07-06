{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
      bolt-launcher
      github-desktop
      youtube-music
      vscodium
      protontricks
      nwg-look
      imagemagick
      nicotine-plus
      gnome-disk-utility
      (flameshot.override {
      enableWlrSupport = true;
      })
      overskride
      cemu
  ];
  nixpkgs.overlays = [
  (self: super: {
    bolt-launcher = super.bolt-launcher.override {
      enableRS3 = true;
      };
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
   "openssl-1.1.1w"
  ];
}

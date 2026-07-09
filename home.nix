{
  config,
  pkgs,
  helium,
  ...
}:

{
  home.username = "array";
  home.homeDirectory = "/home/array";

  home.stateVersion = "26.11";

  programs.home-manager.enable = true;
  home.enableNixpkgsReleaseCheck = false;

  targets.genericLinux.enable = true;
  programs.git.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "pnpm-10.29.2"
  ];

  home.packages = with pkgs; [
    feishin
    joshuto
    xcolor
    tdrop
    brightnessctl
    wiremix
    bluetui
    bolt-launcher
    helium.packages.${system}.default
  ];

  imports = [
    ./home/config.nix
    ./modules/default.nix
  ];

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 32;
  };
}

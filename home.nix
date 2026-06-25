{
  config,
  pkgs,
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

  home.packages = with pkgs; [
    feishin
    joshuto
    xcolor
    tdrop
    brightnessctl
    skippy-xd
    wiremix
    bluetui
    bsp-layout
  ];

  imports = [
    ./home/config.nix
    ./modules/default.nix

  ];
}

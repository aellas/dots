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

  home.packages = with pkgs; [
    feishin
    xcolor
    brightnessctl
    wiremix
    bluetui
    helium.packages.${stdenv.hostPlatform.system}.default
    localsend
    signal-desktop
    lxappearance
    discord
    pcmanfm-qt
    opencode
    programs.talib
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

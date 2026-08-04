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

  home.packages = with pkgs; [
  ];

  imports = [
    ./home/default.nix
    ./modules/default.nix
  ];

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 32;
  };
}

{ config, pkgs, inputs, zen-browser, system, ... }:
{
 home.username = "array";
  home.homeDirectory = "/home/array";

  home.stateVersion = "26.05";

home.packages = [
  pkgs.feishin
  pkgs.joshuto
  pkgs.shotman
      zen-browser.packages.${system}.default
];
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

 imports = [
 ];
  programs.home-manager.enable = true;
}

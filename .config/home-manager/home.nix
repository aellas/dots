{ config, pkgs, ... }:
{
 home.username = "array";
  home.homeDirectory = "/home/array";

  home.stateVersion = "26.05";

home.packages = [
  pkgs.feishin
  pkgs.joshuto
  pkgs.shotman
];
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}

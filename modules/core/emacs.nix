{ config, lib, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    defaultEditor = true;
  };
}

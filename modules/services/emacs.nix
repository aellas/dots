{ config, lib, pkgs, ... }:

{
  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
}

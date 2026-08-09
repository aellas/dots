{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./xcolor.nix
    ./betterlockscreen.nix
  ];
}

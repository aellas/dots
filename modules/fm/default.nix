{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./dolphin.nix
    ./thunar.nix
  ];
}

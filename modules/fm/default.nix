{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./dolphin.nix
    ./pcmanfm-qt.nix
  ];
}

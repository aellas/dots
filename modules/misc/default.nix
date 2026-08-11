{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./xcolor.nix
    ./tdrop.nix
  ];
}

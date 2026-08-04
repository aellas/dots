{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./floorp.nix
    ./librewolf.nix
    ./helium.nix
  ];
}

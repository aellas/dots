{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./config/symlink.nix
  ];
}

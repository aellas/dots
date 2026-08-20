{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./bluetui.nix
    ./wiremix.nix
    ./opencode.nix
    ./herdr.nix
    ./impala.nix
  ];
}

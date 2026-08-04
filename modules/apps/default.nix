{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./discord.nix
    ./localsend.nix
    ./signal.nix
  ];
}

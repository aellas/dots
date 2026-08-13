{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./bluetui.nix
    ./opencode.nix
    ./wiremix.nix
    ./tmux.nix
  ];
}

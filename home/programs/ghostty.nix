{ config, pkgs, ... }:
let
  myGhostty = pkgs.ghostty.overrideAttrs (_: {
    preBuild = ''
      shopt -s globstar
      sed -i 's/^const xev = @import("xev");$/const xev = @import("xev").Epoll;/' **/*.zig
      shopt -u globstar
    '';
  });
in
{
  programs.ghostty = {
    enable = true;
    package = myGhostty;
    settings = {
      font-size = 10;
      font-family = "JetBrainsMono NF";
      font-style = "bold";
      font-thicken = "true";
      window-decoration = "false";
      confirm-close-surface = "false";
    };
  };
}
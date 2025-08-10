{ config, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 10;
      font-family = "JetBrainsMono NF";
      font-style = "bold";
      font-thicken = "true";
      window-decoration = "false";
      confirm-close-surface = "false";
      theme = "iceberg-dark";
    };
  };
}

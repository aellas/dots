{ pkgs, ... }:
{
    programs.xplr = {
        enable = true;
    };

  home.packages = with pkgs; [
  ];
}
{ pkgs, ... }:
{
    programs.nnn = {
        enable = true;
    };

  home.packages = with pkgs; [
  ];
}
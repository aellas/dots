{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      fastfetch

    '';

    shellAliases = {
      ls = "ls --color=auto";
      uu = "cd /home/array/Documents/GitHub/nixos-testing && sudo nixos-rebuild switch --flake .#arynix";
      uf = "cd /home/array/Documents/GitHub/nixos-testing && nix flake update";
    };
  };
}

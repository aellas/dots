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
      uu = "echo 'ra = rebuild arynix \nrx = rebuild xpsnix \nrt = rebuld thinknix'";
      ra = "cd /home/array/Documents/nixos/main && sudo nixos-rebuild switch --flake .#arynix";
      rx = "cd /home/array/Documents/nixos/main && sudo nixos-rebuild switch --flake .#xpsnix";
      rt = "cd /home/array/Documents/nixos/main && sudo nixos-rebuild switch --flake .#thinknix";
      uf = "cd /home/array/Documents/nixos/main && nix flake update";
    };
  };
}

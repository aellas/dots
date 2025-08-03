{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      fastfetch

      set -gx PATH $HOME/.config/emacs/bin $PATH

    '';

    shellAliases = {
      ls = "ls --color=auto";
      uu = "echo 'ra = rebuild arynix \nrx = rebuild xpsnix \nrt = rebuld thinknix'";
      ra = "cd /home/array/Documents/GitHub/dots && sudo nixos-rebuild switch --flake .#arynix";
      rx = "cd /home/array/Documents/GitHub/dots && sudo nixos-rebuild switch --flake .#xpsnix";
      rt = "cd /home/array/Documents/GitHub/dots && sudo nixos-rebuild switch --flake .#thinknix";
      rp = "cd /home/array/Documents/GitHub/dots && sudo nixos-rebuild switch --flake .#proxnix";
      uf = "cd /home/array/Documents/GitHub/dots && nix flake update";
      ss = "sudo sshfs array@192.168.1.35:/home/array/Documents/nixos /home/array/Documents/nixos -o allow_other";
    };
  };
}

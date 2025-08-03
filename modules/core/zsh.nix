# /etc/nixos/system/zsh.nix (or wherever you import it)
{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestions = {
      enable = true;
      highlightStyle = "fg=8";
    };

    interactiveShellInit = ''
      # Run fastfetch on shell start
      if [ -x "$(command -v fastfetch)" ]; then
        fastfetch
      fi
      export $EDITOR nvim
    '';

    shellAliases = {
      ls = "ls --color=auto";
      uu = "cd /home/array/nixos-testing && sudo nixos-rebuild switch --flake .#arynix";
    };

  };
}

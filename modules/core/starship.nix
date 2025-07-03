{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      command_timeout = 1000; # Timeout for commands in ms
    format = "$all$nix_shell$nodejs$lua$golang$rust$php$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      # Example module configuration
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
      git_branch = {
        symbol = "🌱 ";
      };
      # ... other Starship settings
    };
  };

  # ... rest of your configuration ...
}
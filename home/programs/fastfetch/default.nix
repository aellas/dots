{
  programs.fastfetch = {
    enable = true;

    settings = {
      separator = "- ";

    display = {
      constants = [
          "██ "
      ];
    };

      logo = {
        source = ./nixos.webp;
        type = "kitty"; 
        padding = {
          top = 2;
          right = 5;
          left = 3;
        };
      };

      modules = [
      "break"
      "break"
        {
            type = "os";
            key = "{$1}Distro";
            format = "{3}";
            keyColor = "38;5;147";
        }
        {
            type = "kernel";
            key = "{$1}Kernel";
            keyColor = "38;5;75";
        }
        {
            type = "packages";
            key = "{$1}Packages";
            keyColor = "38;5;123";
        }
        {
            type = "uptime";
            key = "{$1}Uptime";
            keyColor = "38;5;147";
        }
        {
            type = "terminal";
            key = "{$1}Terminal";
            keyColor = "38;5;75";
        }
        {
            type = "shell";
            key = "{$1}Shell";
            keyColor = "38;5;123";
        }
        {
            type = "wm";
            key = "{$1}WM";
            format = "{19}";
            keyColor = "38;5;147";
        }
        {
            type = "command";
            keyColor ="38;5;75";
            key = "{$1}Day";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference";
        }
        {
            type = "command";
            keyColor ="38;5;123";
            key = "{$1}Left";
            text = "echo \"$(( ($(date -d \"$(date -d \"@$(stat -c %W /)\" \"+%Y-%m-%d\") + 2 years\" \"+%s\") - $(date +%s)) / 86400 ))\"";        
          }
      ];
    };
  };
}

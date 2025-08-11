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
        type = "none";
        padding = {
          top = 2;
          right = 5;
          left = 3;
        };
      };
    modules = [
      "break"

              {
            type = "os";
            key = "  Distro";
            format = "{3}";
        }

        {
            type = "host";
            key = "  Host";
            format = "{1}";
       }
        {
            type = "kernel";
            key = "  Kernel";
        }
        {
            type = "packages";
            key = "  Packages";
        }
        {
           type = "editor";
           key = "  Editor";
        }
        {
            type = "uptime";
            key = "  Uptime";
        }
        {
            type = "wm";
            key = "  WM";
            format = "Qtile (Wayland)";
        }        {
            type = "command";
            key = "  Day";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference";
        }
        {
            type = "command";
            key = "  Left";
            text = "echo \"$(( ($(date -d \"$(date -d \"@$(stat -c %W /)\" \"+%Y-%m-%d\") + 2 years\" \"+%s\") - $(date +%s)) / 86400 ))\"";        
          }
      ];
    };
    
  };
}

{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Ubuntu Nerd Font";
      font_size = 10;
      confirm_os_window_close = 0;
    };
    extraConfig = ''
      include ~/.cache/wal/colors-kitty.conf
    '';
  };
}
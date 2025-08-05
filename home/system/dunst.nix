{
  services.dunst = {
    enable = true;
    waylandDisplay = "wayland-0";

    settings = {
      global = {
        height = "(0, 400)";
        width = "(0, 400)";
        separator_height = 0;
        padding = 8;
        horizontal_padding = 8;
        frame_color = "#5f6061";
        frame_width = 0;
        origin = "top-right";
        idle_threshold = 120;
        font = "JetBrainsMono Nerd Font 11";
        alignment = "center";
        word_wrap = "yes";
        notification_limit = 1;
        format = "<b>%s</b>: %b";
        markup = "full";
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_low = {
        background = "#161821";
        foreground = "#ffffff";
      };

      urgency_normal = {
        background = "#161821";
        foreground = "#ffffff";
      };

      urgency_critical = {
        background = "#161821";
        foreground = "#ffffff";
      };
    };
  };
}

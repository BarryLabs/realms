{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.mods.wm.wayland.dunst.abyss;
in {
  options.mods.wm.wayland.dunst.abyss.enable = mkEnableOption "enable dunst notifications for abyss";
  config = mkIf cfg.enable {
    services = {
      dunst = {
        enable = true;
        settings = {
          global = {
            browser = "${pkgs.qutebrowser}/bin/qutebrowser";
            dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
            corner_radius = 6;
            follow = "mouse";
            font = "Source Code Pro 11";
            format = "<b>%s</b>\\n%b";
            frame_color = "#89b4fa";
            frame_width = 2;
            geometry = "300x5-5+30";
            horizontal_padding = 8;
            highlight = "#89b4fa";
            icon_position = "off";
            indicate_hidden = "yes";
            line_height = 0;
            markup = "full";
            mouse_left_click = "do_action";
            mouse_middle_click = "close_all";
            mouse_right_click = "close_current";
            padding = 8;
            progress_bar = true;
            separator_color = "frame";
            separator_height = 2;
            show_indicators = "yes";
            sort = "yes";
            transparency = 10;
            word_wrap = true;
          };
          urgency_low = {
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            timeout = 10;
          };
          urgency_normal = {
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            timeout = 15;
          };
          urgency_critical = {
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            frame_color = "#fab387";
            timeout = 0;
          };
        };
      };
    };
  };
}

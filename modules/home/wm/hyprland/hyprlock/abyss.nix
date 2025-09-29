{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.hyprlock.abyss;
in
{
  options.mods.wm.wayland.hyprlock.abyss.enable = mkEnableOption "enable hyprlock for abyss";
  config = mkIf cfg.enable {
    programs = {
      hyprlock = {
        enable = true;
        settings = {
          general = {
            disable_loading_bar = true;
            grace = 5;
            hide_cursor = true;
            no_fade_in = false;
          };
          background = [
            {
              blur_size = 2;
              blur_passes = 2;
              path = "/etc/nixos/.config/hyprlock/background.jpeg";
            }
          ];
          image = [
            {
              path = "/etc/nixos/.config/hyprlock/image.jpg";
              size = 150;
              border_size = 4;
              border_color = "rgb(0C96F9)";
              rounding = -1;
              position = "0, 200";
              halign = "center";
              valign = "center";
            }
          ];
          input-field = [
            {
              size = "200, 50";
              position = "0, -80";
              monitor = "";
              dots_center = true;
              fade_on_empty = false;
              font_color = "rgb(CFE6F4)";
              inner_color = "rgb(657DC2)";
              outer_color = "rgb(0D0E15)";
              outline_thickness = 5;
              placeholder_text = "Password...";
              shadow_passes = 2;
            }
          ];
        };
      };
    };
  };
}

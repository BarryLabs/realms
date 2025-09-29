{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.hyprland.yggdrasil;
in
{
  options.mods.wm.wayland.hyprland.yggdrasil.enable =
    mkEnableOption "Base Hyprland Module for Yggdrasil";
  config = mkIf cfg.enable {
    wayland = {
      windowManager = {
        hyprland =
          let
            init = pkgs.pkgs.writeShellScriptBin "init" ''
              ${pkgs.hypridle}/bin/hypridle &
              ${pkgs.waybar}/bin/waybar &
              ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store &
              ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store &
            '';
          in
          {
            enable = true;
            package = null;
            portalPackage = null;
            plugins = with pkgs.hyprlandPlugins; [
              # hyprgrass
              borders-plus-plus
              hypr-dynamic-cursors
            ];
            settings = {
              exec-once = ''
                ${init}/bin/init
              '';
              monitor = [
                "HDMI-A-1,2560x1080@165,1920x0,1"
                "HDMI-A-2,1920x1080@144,0x0,1"
              ];
              xwayland = {
                force_zero_scaling = true;
              };
              env = [
                "DISPLAY,:0"
                "NIXOS_OZONE_WL,1"
                "WAYLAND_DISPLAY,wayland-1"
                "WLR_NO_HARDWARE_CURSORS,1"
              ];
              "$mod" = "SUPER";
              input = {
                kb_layout = "us";
                kb_variant = "";
                kb_model = "";
                kb_rules = "";
                kb_options = "ctrl:nocaps";
                follow_mouse = 1;
                numlock_by_default = true;
              };
              general = {
                gaps_in = 4;
                gaps_out = 5;
                border_size = 1;
                layout = "dwindle";
                "col.active_border" = "rgba(9742b5ee) rgba(9742b5ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";
              };
              animations = {
                enabled = true;
                bezier = "ogBezier, 0.15, 1, 0.3, 1.1";
                animation = [
                  "windows, 1, 7, ogBezier"
                  "windowsOut, 1, 7, default, popin 80%"
                  "border, 1, 10, default"
                  "borderangle, 1, 8, default"
                  "fade, 1, 7, default"
                  "workspaces, 1, 6, default"
                ];
              };
              decoration = {
                rounding = 6;
                blur = {
                  enabled = true;
                  size = 2;
                  passes = 2;
                };
                shadow = {
                  enabled = true;
                  range = 60;
                  render_power = 3;
                  color = "rgba(1E202966)";
                  offset = "1 2";
                  scale = 0.97;
                };
                active_opacity = 0.9;
                inactive_opacity = 0.7;
              };
              windowrule = [
                "float, class:file_progress"
                "float, class:confirm"
                "float, class:dialog"
                "float, class:download"
                "float, class:notification"
                "float, class:error"
                "float, class:splash"
                "float, class:confirmreset"
                "float, title:Open File"
                "float, title:branchdialog"
                "fullscreen, class:wlogout"
                "float, title:wlogout"
                "fullscreen, title:wlogout"
                "float, class:mpv"
                "idleinhibit focus, class:mpv"
                "opacity 1.0 override, class:firefox"
                "opacity 1.0 override, class:qutebrowser"
                "opacity 1.0 override, class:mpv"
                "float, title:^(kitty)$"
                "float, title:^(foot)$"
                "float, title:^(ghostty)$"
                "float, title:^(wezterm)$"
              ];
              bind = [
                "$mod SHIFT, Q, exit"
                "$mod, Q, killactive"
                "$mod, F, fullscreen"
                "$mod, X, exec, hyprctl kill"
                "$mod, RETURN, exec, wezterm"
                "$mod, B, exec, qutebrowser"
                "$mod, V, exec, blender"
                "$mod, E, exec, emoji"
                "$mod, I, exec, gimp"
                "$mod, C, exec, hyprpicker"
                "$mod, G, exec, screenshot"
                "$mod, M, exec, rofi-launcher"
                "$mod, A, exec, help-menu"
                "$mod, Space, togglefloating"
                "$mod SHIFT, left, movewindow, l"
                "$mod SHIFT, right, movewindow, r"
                "$mod SHIFT, up, movewindow, u"
                "$mod SHIFT, down, movewindow, d"
                "$mod CTRL, left, resizeactive, -20 0"
                "$mod CTRL, right, resizeactive, 20 0"
                "$mod CTRL, up, resizeactive, 0 -20"
                "$mod CTRL, down, resizeactive, 0 20"
                "$mod, mouse_down, workspace, e+1"
                "$mod, mouse_up, workspace, e-1"
                "$mod, h, movefocus, l"
                "$mod, l, movefocus, r"
                "$mod, k, movefocus, u"
                "$mod, j, movefocus, d"
                "$mod, 1, workspace, 1"
                "$mod, 2, workspace, 2"
                "$mod, 3, workspace, 3"
                "$mod, 4, workspace, 4"
                "$mod, 5, workspace, 5"
                "$mod, 6, workspace, 6"
                "$mod, 7, workspace, 7"
                "$mod, 8, workspace, 8"
                "$mod, 9, workspace, 9"
                "$mod ALT, up, workspace, e+1"
                "$mod ALT, down, workspace, e-1"
                "$mod SHIFT, 1, movetoworkspace, 1"
                "$mod SHIFT, 2, movetoworkspace, 2"
                "$mod SHIFT, 3, movetoworkspace, 3"
                "$mod SHIFT, 4, movetoworkspace, 4"
                "$mod SHIFT, 5, movetoworkspace, 5"
                "$mod SHIFT, 6, movetoworkspace, 6"
                "$mod SHIFT, 7, movetoworkspace, 7"
                "$mod SHIFT, 8, movetoworkspace, 8"
                "$mod SHIFT, 9, movetoworkspace, 9"
              ];
              bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
              ];
            };
          };
      };
    };
  };
}

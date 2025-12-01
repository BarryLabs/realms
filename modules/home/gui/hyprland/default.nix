{ config
, lib
, pkgs
, vars
, ...
}:
with lib;
let
  module = "hyprland";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable =
    mkEnableOption "Hyprland Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      #hyprland
      hypridle
      #hyprpaper
      hyprpicker
      waybar
      wl-clipboard
    ];
    programs = {
      waybar = {
        enable = true;
        settings = {
          bottomBar = {
            layer = "top";
            position = "bottom";
            height = 12;
            output =
              if vars.user == "chandler" then [
                "HDMI-A-1"
                "HDMI-A-2"
              ] else if vars.user == "mamotdask" then [
                "eDP-1"
              ] else [ ];
            modules-center = [
              "wlr/taskbar"
            ];
            "wlr/taskbar" = {
              format = "{icon}";
              icon-size = 14;
              tooltip-format = "{title} | {app_id}";
              on-click = "activate";
              on-click-middle = "close";
            };
          };
          mainBar = {
            layer = "top";
            position = "top";
            height = 23;
            output =
              if vars.user == "chandler" then [
                "HDMI-A-1"
                "HDMI-A-2"
              ] else if vars.user == "mamotdask" then [
                "eDP-1"
              ] else [ ];
            modules-left = [
              "custom/startmenu"
              "clock"
              "cpu"
              "memory"
              "disk"
            ];
            modules-center = [
            ];
            modules-right = [
              "network"
              "pulseaudio"
              "privacy"
              "custom/logout"
            ];
            "custom/startmenu" = {
              tooltip = false;
              format = "";
              on-click = "sleep 0.1 && rofi -show drun";
            };
            "clock" = {
              format = " {:%I:%M %p}";
              tooltip = true;
              tooltip-format = "<small>{:%A, %d.%B %Y }</small>\n<tt><big>{calendar}</big></tt>";
            };
            "disk" = {
              path = "/";
              tooltip = true;
              format = " {free}/{total}";
            };
            "memory" = {
              interval = 5;
              tooltip = true;
              format = " {used:0.1f}G/{total:0.1f}G";
            };
            "cpu" = {
              format = " {}%";
              on-click = "htop";
              internal = 5;
              max-length = 10;
            };
            "network" = {
              format = "{ifname}";
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = " {ipaddr}";
              format-disconnected = "";
              tooltip-format = "{ifname} via {gwaddr} 󰊗";
              tooltip-format-wifi = "{essid} ({signalStrength}%) ";
              tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
              tooltip-format-disconnected = "Disconnected";
              interval = 5;
            };
            "pulseaudio" = {
              format = "{icon} {volume}%";
              format-bluetooth = "{volume}% {icon}";
              format-muted = "";
              format-icons = {
                headphone = "";
                headset = "";
                phone = "";
                phone-muted = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                ];
              };
              scroll-step = 1;
              on-click = "pavucontrol";
              ignored-sinks = [ "Easy Effects Sink" ];
            };
            "privacy" = {
              icon-size = 12;
            };
            "idle_inhibitor" = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
            "custom/logout" = {
              tooltip = false;
              format = "";
              on-click = "sleep 0.1 && wlogout";
            };
          };
        };
        style = lib.mkAfter ''
           * {
          font-family: JetBrains Mono NerdFont;
          font-size: 12px;
             border: none;
             border-radius: 0px;
             min-height: 0px;
             padding: 0 5px;
          }

          window#waybar {
             background: rgba(0,0,0,0);
          }

          .modules-center {
            padding: 2px;
            border-radius: 1rem;
          }

          #custom-startmenu {
             color: #000000;
             background: #7287fd;
             margin: 3px;
             padding: 0px 10px 0px 10px;
             border-radius: 15px 15px 15px 15px;
          }

          #custom-logout {
             color: #000000;
             background: #e64553;
             margin: 3px;
             padding: 0px 10px 0px 10px;
             border-radius: 15px 15px 15px 15px;
          } 

          @keyframes blink {
             to {
               color: #000000;
               background: #ffffff;
             }
          } 

          #clock {
            color: #000000;
            background: #c6a0f6;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #taskbar {
            margin: 0rem;
            background: #fab387;
            padding: 0rem 0.5rem 0rem 0rem;
            border-radius: 0.5rem 0.5rem 0.5rem 0.5rem;       
          }
          #taskbar button {
            padding: 0rem 0rem 0rem 0rem;
            border-radius: 0.5rem;
            transition: all 0.2s ease-in-out;
          }
        
          #disk {
            color: #000000;
            background: #8caaee;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #memory {
            color: #000000;
            background: #81c8be;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #cpu {
            color: #000000;
            background: #a6d189;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #pulseaudio {
            color: #000000;
            background: #e5c890;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #network {
            color: #000000;
            background: #f38ba8;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #privacy {
            color: #000000;
            background: #ea999c;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #backlight {
            color: #000000;
            background: #fab387;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }
        '';
      };
    };
    services.hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "hyprlock";
          }
          {
            timeout = 900;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
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
              hyprgrass
              borders-plus-plus
              hypr-dynamic-cursors
            ];
            settings = {
              exec-once = ''
                ${init}/bin/init
              '';
              monitor = [
                ",preferred,auto,1"
              ];
              # monitor =
              #   if vars.user == "chandler" then [
              #     "HDMI-A-1,2560x1080@165,1920x0,1"
              #     "HDMI-A-2,1920x1080@144,0x0,1"
              #   ] else if vars.user == "mamotdask" then [
              #     ",preferred,auto,1"
              #   ] else [ ];
              xwayland = {
                force_zero_scaling = true;
              };
              env = [
                "DISPLAY,:0"
                "NIXOS_OZONE_WL,1"
                "WAYLAND_DISPLAY,wayland-1"
                "WLR_NO_HARDWARE_CURSORS,1"
              ];
              "$mod" = "ALT";
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
                # "col.active_border" = "rgba(9742b5ee) rgba(9742b5ee) 45deg";
                # "col.inactive_border" = "rgba(595959aa)";
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
                  # color = "rgba(1E202966)";
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
                "$mod, RETURN, exec, foot"
                "$mod, B, exec, firefox"
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

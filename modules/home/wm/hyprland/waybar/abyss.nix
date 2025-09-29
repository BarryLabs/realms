{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.waybar.abyss;
in
{
  options.mods.wm.wayland.waybar.abyss.enable = mkEnableOption "enable waybar for abyss";
  config = mkIf cfg.enable {
    programs = {
      waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 14;
            output = [ "eDP-1" ];
            modules-left = [
              "custom/startmenu"
              "battery"
              "clock"
            ];
            modules-center = [
              "hyprland/workspaces"
            ];
            modules-right = [
              "cpu"
              "memory"
              "disk"
              "network"
              "pulseaudio"
              "backlight"
              "custom/logout"
            ];
            "custom/startmenu" = {
              tooltip = false;
              format = "";
              on-click = "sleep 0.1 && rofi -show drun";
            };
            "custom/logout" = {
              tooltip = false;
              format = "";
              on-click = "sleep 0.1 && wlogout";
            };
            "battery" = {
              interval = 5;
              format = "{icon} {capacity}%";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
              tooltip = true;
              tooltip-format = "{timeTo}";
              states = {
                warning = 30;
                critical = 15;
              };
            };
            "clock" = {
              format = " {:%I:%M %p}";
              tooltip = true;
              tooltip-format = "<small>{:%A, %d.%B %Y }</small>\n<tt><big>{calendar}</big></tt>";
            };
            "hyprland/window" = {
              icon = true;
              icon-size = 12;
              rewrite = {
                "" = " No Windows?? ";
                "(.*) - Vesktop" = "$1";
              };
            };
            "hyprland/workspaces" = {
              format = "{icon}";
              format-icons = {
                active = "";
                empty = "";
                default = "";
                urgent = "";
                special = "󰠱";
              };
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
            };
            "disk" = {
              path = "/";
              tooltip = true;
              format = " {percentage_free}%/100%";
            };
            "memory" = {
              interval = 5;
              tooltip = false;
              format = " {used:0.1f}G/{total:0.1f}G";
            };
            "cpu" = {
              internal = 5;
              format = " {}%";
              max-length = 10;
            };
            "network" = {
              interface = "wlan0";
              format = "{ifname}";
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ipaddr}/{cidr} 󰊗";
              format-disconnected = "";
              tooltip-format = "{ifname} via {gwaddr} 󰊗";
              tooltip-format-wifi = "{essid} ({signalStrength}%) ";
              tooltip-format-ethernet = "{ifname} ";
              tooltip-format-disconnected = "Disconnected";
            };
            "pulseaudio" = {
              format = "{volume}% {icon}";
              format-bluetooth = "{volume}% {icon}";
              format-muted = "";
              format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
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
            "idle_inhibitor" = {
              format = "{icon}";
              format-icons = {
                activated = "";
                deactivated = "";
              };
            };
            "backlight" = {
              device = "intel_backlight";
              format = "{icon} {percent}%";
              format-icons = [
                ""
                ""
              ];
            };
          };
        };
        style = ''
           * {
          font-family: JetBrains Mono NerdFont;
          font-size: 14px;
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

          #battery {
             color: #000000;
             background: #a6da95;
             margin: 3px;
             border-radius: 15px 15px 15px 15px;
             padding: 0px 10px 0px 10px;
          }

          #battery.charging {
             color: #000000;
             background: #8839ef;
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

          #battery.critical:not(.charging) {
            color: #4c4f69;
            background: #d20f39;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }

          #clock {
            color: #000000;
            background: #c6a0f6;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #workspaces {
            background: linear-gradient(45deg, #f38ba8, #74c7ec);
            border: solid 0px #000000;
            border-radius: 10px 10px 10px 10px;
            font-weight: normal;
            font-style: normal;
          }
          #workspaces button {
            padding: 0px 10px;
            border-radius: 1rem;
            transition: all 0.2s ease-in-out;
          }

          #tray {
            background: #000000;
            margin: 0px;
            padding: 10px 0px 10px 0px;
            border-radius: 0px 15px 15px 0px;
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

          #idle_inhibitor {
            color: #000000;
            background: #ca9ee6;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }
        '';
      };
    };
  };
}

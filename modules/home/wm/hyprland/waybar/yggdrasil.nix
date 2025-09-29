{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.waybar.yggdrasil;
in
{
  options.mods.wm.wayland.waybar.yggdrasil.enable = mkEnableOption "enable waybar for yggdrasil";
  config = mkIf cfg.enable {
    programs = {
      waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 14;
            output = [
              "HDMI-A-1"
              "HDMI-A-2"
            ];
            modules-left = [
              "custom/startmenu"
              "clock"
              "tray"
              "gamemode"
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
              # "privacy"
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
            "tray" = {
              spacing = 6;
              icon-size = 14;
              show-passive-items = true;
              icons = {
                firefox = "~/Projects/Repos/Realms/.config/waybar/icons/firefox.png";
                keepassxc = "~/Projects/Repos/Realms/.config/waybar/icons/keepassxc.png";
                vesktop = "~/Projects/Repos/Realms/.config/waybar/icons/discord.png";
              };
            };
            "gamemode" = {
              format = "{glyph}";
              format-alt = "{glyph} {count}";
              glyph = "";
              hide-not-running = true;
              use-icon = true;
              icon-name = "input-gaming-symbolic";
              icon-spacing = 4;
              icon-size = 20;
              tooltip-format = "Games running: {count}";
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
              all-outputs = true;
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
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
            # "privacy" = { };
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

          #tray {
            background: #242434;
            margin: 3px;
            padding: 0px 10px 0px 10px;
            border-radius: 15px 15px 15px 15px;
          }

          #gamemode {
            background: #242434;
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

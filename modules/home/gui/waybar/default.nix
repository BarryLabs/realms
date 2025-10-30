{ config
, lib
, vars
, ...
}:
with lib;
let
  module = "waybar";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Waybar Module";
  config = mkIf cfg.enable {
    programs = {
      waybar = {
        enable = true;
        settings = if vars.user == "mamotdask" then { } else {
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
  };
}

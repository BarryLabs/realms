{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "waybar";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Waybar Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pavucontrol
    ];
    programs.${module} = {
      enable = true;
      style = builtins.readFile ./style.css;
      settings = {
        bar = {
          layer = "top";
          position = "top";
          height = 24;
          output = [ "DP-3" ];
          modules-left = [
            "custom/startmenu"
            "clock"
            "cpu"
            "memory"
            "disk"
          ];
          modules-center = [ "wlr/taskbar" ];
          modules-right = [
            "network"
            "pulseaudio"
            "custom/logout"
          ];
          "custom/startmenu" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && fuzzel";
          };
          "clock" = {
            format = " {:%I:%M %p}";
            tooltip = true;
            tooltip-format = "<small>{:%A, %d.%B %Y }</small>\n<tt><big>{calendar}</big></tt>";
          };
          "cpu" = {
            format = " {}%";
            on-click = "htop";
            internal = 5;
            max-length = 10;
          };
          "memory" = {
            interval = 5;
            tooltip = true;
            format = " {used:0.1f}G/{total:0.1f}G";
          };
          "wlr/taskbar" = {
            format = "{icon}";
            icon-size = 20;
            tooltip-format = "{title} | {app_id}";
            on-click = "activate";
            on-click-middle = "close";
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
          "custom/logout" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && wlogout";
          };
        };
      };
    };
  };
}

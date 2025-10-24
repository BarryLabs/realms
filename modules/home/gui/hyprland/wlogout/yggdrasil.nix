{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.wlogout.yggdrasil;
in
{
  options.mods.wm.wayland.wlogout.yggdrasil.enable = mkEnableOption "enable wlogout for yggdrasil";
  config = mkIf cfg.enable {
    programs = {
      wlogout = {
        enable = true;
        layout = [
          {
            label = "shutdown";
            action = "sleep 1; systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            "label" = "reboot";
            "action" = "sleep 1; systemctl reboot";
            "text" = "Reboot";
            "keybind" = "r";
          }
          {
            "label" = "logout";
            "action" = "sleep 1; hyprctl dispatch exit";
            "text" = "Exit";
            "keybind" = "e";
          }
          {
            "label" = "suspend";
            "action" = "sleep 1; systemctl suspend";
            "text" = "Suspend";
            "keybind" = "u";
          }
          {
            "label" = "lock";
            "action" = "sleep 1; hyprlock";
            "text" = "Lock";
            "keybind" = "l";
          }
          {
            "label" = "hibernate";
            "action" = "sleep 1; systemctl hibernate";
            "text" = "Hibernate";
            "keybind" = "h";
          }
        ];
        style = ''
           * {
            background-image: none;
            box-shadow: none;
           }
           window {
             background-color: rgba(30, 30, 46, 0.90);
           }
           button {
          border-radius: 0;
          border-color: #fab387;
          text-decoration-color: #cdd6f4;
          color: #cdd6f4;
          background-color: #181825;
          border-style: solid;
          border-width: 1px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
           }
           button:focus,
           button:active,
           button:hover {
             background-color: rgb(48, 50, 66);
             outline-style: none;
           }
           #logout {
            margin: 10px;
            border-radius: 20px;
             background-image: url("/etc/nixos/.config/wlogout/logout.png");
           }
           #suspend {
            margin: 10px;
            border-radius: 20px;
             background-image: url("/etc/nixos/.config/wlogout/suspend.png");
           }
           #shutdown {
            margin: 10px;
            border-radius: 20px;
             background-image: url("/etc/nixos/.config/wlogout/shutdown.png");
           }
           #reboot {
            margin: 10px;
            border-radius: 20px;
             background-image: url("/etc/nixos/.config/wlogout/reboot.png");
           }
           #lock {
            margin: 10px;
            border-radius: 20px;
             background-image: url("/etc/nixos/.config/wlogout/lock.png");
           }
           #hibernate {
            margin: 10px;
            border-radius: 20px;
             background-image: url("/etc/nixos/.config/wlogout/hibernate.png");
           }
        '';
      };
    };
  };
}

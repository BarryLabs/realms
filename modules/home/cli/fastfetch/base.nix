{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.cli.fastfetch.base;
in
{
  options.mods.cli.fastfetch.base.enable = mkEnableOption "Base Fastfetch Module";
  config = mkIf cfg.enable {
    programs = {
      fastfetch = {
        enable = true;
        settings = {
          # display = {
          #   color = {
          #     keys = "red";
          #     output = "green";
          #   };
          # };
          logo = {
            #source = ;
            type = "chafa";
            height = 15;
            width = 30;
            padding = {
              top = 1;
              left = 2;
              preserveAspectRatio = true;
            };
          };
          modules = [
            "break"
            {
              type = "custom";
              format = "┌──────────────────────Hardware──────────────────────┐";
            }
            {
              type = "cpu";
              key = "│  ";
            }
            {
              type = "gpu";
              key = "│ 󰍛 ";
            }
            {
              type = "memory";
              key = "│ 󰑭 ";
            }
            {
              type = "uptime";
              key = "│  ";
            }
            {
              type = "custom";
              format = "└────────────────────────────────────────────────────┘";
            }
            "break"
            {
              type = "custom";
              format = "┌──────────────────────Software──────────────────────┐";
            }
            {
              type = "custom";
              format = " OS -> Realms 0.1.0";
            }
            {
              type = "kernel";
              key = "│ ├ ";
            }
            {
              type = "packages";
              key = "│ ├󰏖 ";
            }
            {
              type = "shell";
              key = "└ └ ";
            }
            "break"
            {
              type = "wm";
              key = " WM";
            }
            {
              type = "wmtheme";
              key = "│ ├󰉼 ";
            }
            {
              type = "terminal";
              key = "└ └ ";
            }
            {
              type = "custom";
              format = "└────────────────────────────────────────────────────┘";
            }
            "break"
          ];
        };
      };
    };
  };
}

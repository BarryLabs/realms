{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "steam";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Steam Module";
  config = mkIf cfg.enable {
    nixpkgs = {
      config = {
        allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "steam"
            "steam-unwrapped"
          ];
      };
    };
    hardware = {
      xone = {
        enable = true;
      };
    };
    environment = {
      systemPackages = [ pkgs.gamemode ];
    };
    systemd.user.tmpfiles.users.${config.var.user}.rules = lib.optional config.programs.steam.enable
      "L %h/.local/share/Steam/steam_dev.cfg - - - - /etc/nixos/modules/system/programs/steam/steam_dev.cfg";
    programs = {
      gamemode = {
        enable = true;
      };
      gamescope = {
        enable = true;
        capSysNice = true;
        args = [
          "--rt"
          "--expose-wayland"
        ];
      };
      ${module} = {
        enable = true;
        dedicatedServer = {
          openFirewall = true;
        };
        gamescopeSession = {
          enable = true;
        };
        remotePlay = {
          openFirewall = true;
        };
      };
    };
  };
}

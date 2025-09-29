{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.programs.steam;
in
{
  options.augs.programs.steam.enable = mkEnableOption "Base Steam Module";
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
    environment = {
      systemPackages = [ pkgs.gamemode ];
    };
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
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
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

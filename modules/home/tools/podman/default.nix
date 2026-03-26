{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "podman";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Podman Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      podman-compose
    ];
    services = {
      podman = {
        enable = true;
        autoUpdate = {
          enable = true;
          onCalendar = "Sun *-*-* 00:00";
        };
        settings = {
          registries = {
            search = [
              "quay.io"
              "docker.io"
            ];
          };
        };
      };
    };
  };
}

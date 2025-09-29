{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.tools.podman.base;
in
{
  options.mods.tools.podman.base.enable = mkEnableOption "Base Podman Module";
  config = mkIf cfg.enable {
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

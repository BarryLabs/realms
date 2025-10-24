{ config
, lib
, ...
}:
with lib;
let
  module = "podman";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Base Podman Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/podman"
    #   ];
    # };
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

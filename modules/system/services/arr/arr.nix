{
  config,
  lib,
  ...
}:
with lib;
let
  module = "arr";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "AIO Arr Module";
  config = mkIf cfg.enable {
    services = {
      jellyseerr = {
        enable = true;
        openFirewall = true;
      };
      jellyfin = {
        enable = true;
        openFirewall = true;
        dataDir = "/srv/jellyfin/Data";
        cacheDir = "/srv/jellyfin/Cache";
      };
      prowlarr = {
        enable = true;
        openFirewall = true;
      };
      radarr = {
        enable = true;
        openFirewall = true;
        dataDir = "/srv/radarr/Data";
      };
      sonarr = {
        enable = true;
        openFirewall = true;
        dataDir = "/srv/sonarr/Data";
      };
    };
  };
}

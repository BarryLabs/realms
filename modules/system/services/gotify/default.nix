{ config
, lib
, ...
}:
with lib; let
  module = "gotify";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Gotify Module";
  config = mkIf cfg.enable {
    services = {
      gotify = {
        enable = true;
        environment = {
          GOTIFY_SERVER_PORT = 8080;
          GOTIFY_DATABASE_DIALECT = "sqlite3";
        };
      };
    };
  };
}

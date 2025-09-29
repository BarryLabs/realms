{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.gotify;
in
{
  options.augs.services.gotify.enable = mkEnableOption "Base Gotify Module";
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

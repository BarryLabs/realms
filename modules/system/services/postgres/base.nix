{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.postgres;
in
{
  options.augs.services.postgres.enable = mkEnableOption "Base Postgres Module";
  config = mkIf cfg.enable {
    services = {
      postgresql = {
        enable = true;
        authentication = pkgs.lib.mkOverride 10 ''
          local 	all       all     			            trust
          host  	all      	all     	127.0.0.1/32   	trust
        '';
        identMap = ''
          superuser_map      root      		postgres
          superuser_map      postgres     postgres
          superuser_map      /^(.*)$   		\1
        '';
        settings = {
          logging_collector = true;
          log_connections = true;
          log_statement = "all";
          log_disconnections = true;
          log_destination = lib.mkForce "stderr";
        };
      };
    };
  };
}

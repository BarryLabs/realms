{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.database;
in
{
  options.augs.services.database.enable = mkEnableOption "Postgres Module for Realms";
  config = mkIf cfg.enable {
    services = {
      pgadmin = {
        enable = true;
        openFirewall = true;
        initialEmail = "host.clang101@aleeas.com";
        initialPasswordFile = config.sops.secrets.pgAdminKey.path;
      };

      postgresql = {
        enable = true;
        authentication = pkgs.lib.mkOverride 10 ''
          local 	all       all     			            trust
          host  	all      	all     	127.0.0.1/32   	trust
        '';
        identMap = ''
          superuser_map      root      		    postgres
          superuser_map      postgres      	  postgres
          superuser_map      gitea      		  gitea
          superuser_map      nextcloud      	nextcloud
          superuser_map      /^(.*)$   		    \1
        '';
        ensureDatabases = [ "gitea" "nextcloud" ];
        ensureUsers = [
          {
            name = "gitea";
            ensureDBOwnership = true;
          }
          {
            name = "nextcloud";
            ensureDBOwnership = true;
          }
        ];
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

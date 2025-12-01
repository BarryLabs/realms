{ config
, lib
, ...
}:
with lib; let
  module = "gitea";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Gitea Module";
  config = mkIf cfg.enable {
    systemd.services = {
      "initGitea" = {
        requires = [ "postgresql.service" ];
        after = [ "postgresql.service" ];
      };
    };
    services = {
      gitea =
        let
          appName = "Farm Gitea";
          dbCreds = "gitea";
        in
        {
          inherit appName;
          enable = true;
          useWizard = true;
          database = {
            type = "postgres";
            host = "localhost";
            user = dbCreds;
            name = dbCreds;
            passwordFile = config.sops.secrets.GiteaDBKey.path;
          };
          lfs = {
            enable = true;
          };
          settings = {
            log = {
              LEVEL = "Info";
            };
          };
        };
    };
  };
}

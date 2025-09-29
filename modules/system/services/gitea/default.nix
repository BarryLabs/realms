{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.gitea;
in
{
  options.augs.services.gitea.enable = mkEnableOption "Base Gitea Module";
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

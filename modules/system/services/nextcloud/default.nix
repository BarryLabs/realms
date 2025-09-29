{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.augs.services.nextcloud;
in
{
  options.augs.services.nextcloud.enable = mkEnableOption "Nextcloud Module for Realms";
  config = mkIf cfg.enable {
    systemd.services = {
      "initNextcloud" = {
        requires = [ "postgresql.service" ];
        after = [ "postgresql.service" ];
      };
    };
    services = {
      nextcloud =
        let
          dbCreds = "nextcloud";
          host = "192.168.40.5";
        in
        {
          enable = true;
          package = pkgs.nextcloud30;
          hostName = "localhost";
          maxUploadSize = "100G";
          configureRedis = true;
          config = {
            dbtype = "pgsql";
            dbhost = "127.0.0.1";
            dbuser = dbCreds;
            dbname = dbCreds;
            adminuser = "BlueSky";
            dbpassFile = config.sops.secrets.NextcloudDBKey.path;
            adminpassFile = config.sops.secrets.NextcloudAdminKey.path;
          };
          settings = {
            default_phone_region = "US";
            trusted_domains = [
              host
            ];
          };
          extraAppsEnable = true;
          extraApps = with config.services.nextcloud.package.packages.apps; {
            inherit bookmarks calendar contacts cookbook maps news tasks;
            money = pkgs.fetchNextcloudApp {
              license = "gpl3";
              sha256 = "sha256-6ZCVcJRmE2gNsp+Tg7Jcddwv6yqmNFATFHn9x6UJL7c=";
              url = "https://github.com/powerpaul17/nc_money/releases/download/v0.29.1/money.tar.gz";
            };
            # talk = pkgs.fetchNextcloudApp {
            #   license = "gpl3";
            #   sha256 = "sha256-Ld/1UKhch7QYsfxGHpcjviGPna3moMsLCOMOGi937SI=";
            #   url = "https://github.com/nextcloud-releases/spreed/releases/download/v20.1.5/spreed-v20.1.5.tar.gz";
            # };
          };
        };
    };
  };
}

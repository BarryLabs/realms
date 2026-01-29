{ config
, lib
, ...
}:
with lib; let
  module = "asgard";
  cfg = config.augs.backup.${module};
in
{
  options.augs.backup.${module}.enable = mkEnableOption "Backups";
  config = mkIf cfg.enable {
    sops = {
      secrets = {
        "backup/ssh/local" = {
          mode = "0400";
        };
        "backup/ssh/remote" = {
          mode = "0400";
        };
        "backup/repo/local" = {
          mode = "0400";
        };
        "backup/repo/remote" = {
          mode = "0400";
        };
        "backup/key/local" = {
          mode = "0400";
        };
        "backup/key/remote" = {
          mode = "0400";
        };
      };
    };
    services = {
      borgbackup =
        let
          allData = "/srv";
        in
        {
          jobs = {
            localAsgardEnc = {
              startAt = "daily";
              repo = "/asgard/backup/asgard";
              paths = [ allData ];
              compression = "lz4";
              encryption = {
                mode = "repokey-blake2";
                passCommand = "cat /run/secrets/backup/key/local";
              };
              extraCreateArgs = [
                "--stats"
              ];
              environment = {
                BORG_RSH = "ssh -o 'StrictHostKeyChecking=no' -i /run/secrets/backup/ssh/local";
              };
              prune = {
                keep = {
                  within = "30d";
                  daily = 14;
                  weekly = 4;
                  monthly = -1;
                };
              };
            };
            remoteAsgardEnc = {
              startAt = "daily";
              repo = "ssh://m8plj2z8@m8plj2z8.repo.borgbase.com/./repo";
              paths = [ allData ];
              compression = "lz4";
              encryption = {
                mode = "repokey-blake2";
                passCommand = "cat /run/secrets/backup/key/remote";
              };
              extraCreateArgs = [
                "--stats"
              ];
              environment = {
                BORG_RSH = "ssh -o 'StrictHostKeyChecking=no' -i /run/secrets/backup/ssh/remote";
              };
              prune = {
                keep = {
                  within = "30d";
                  daily = 14;
                  weekly = 4;
                  monthly = -1;
                };
              };
            };
          };
        };
    };
  };
}

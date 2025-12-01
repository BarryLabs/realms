{ config
, lib
, ...
}:
with lib; let
  module = "zfs";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "ZFS Module for Realms";
  config = mkIf cfg.enable {
    boot = {
      supportedFilesystems = [ "zfs" ];
      zfs = {
        forceImportRoot =
          if config.networking.hostName == "asgard"
          then lib.mkDefault false
          else lib.mkDefault true;
        extraPools = (
          if config.networking.hostName == "asgard"
          then lib.mkDefault [ "asgard" ]
          else lib.mkDefault [ ]
        );
      };
    };
    networking = {
      hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);
    };
    services = {
      zfs = {
        autoScrub = {
          enable = lib.mkDefault true;
          interval = lib.mkDefault "monthly";
          randomizedDelaySec = lib.mkDefault "12h";
          pools =
            [
              "asgard"
            ];
        };
        autoSnapshot = {
          enable = lib.mkDefault true;
          flags = lib.mkDefault "-k -p --utc";
          frequent = lib.mkDefault 4;
          hourly = lib.mkDefault 24;
          daily = lib.mkDefault 7;
          weekly = lib.mkDefault 4;
          monthly = lib.mkDefault 12;
        };
        trim = {
          enable = lib.mkDefault true;
          interval = lib.mkDefault "weekly";
          randomizedDelaySec = lib.mkDefault "2h";
        };
      };
    };
  };
}

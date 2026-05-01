{config, ...}: {
  flake.nixosModules.raidArray = {lib, ...}: {
    boot = {
      supportedFilesystems = ["zfs"];
      zfs = {
        forceImportRoot = false;
        extraPools = [
          "asgard"
        ];
      };
    };
    networking = {
      hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);
    };
    services = {
      zfs = {
        autoScrub = {
          enable = true;
          interval = "monthly";
          randomizedDelaySec = "12h";
          pools = [
            "asgard"
          ];
        };
        autoSnapshot = {
          enable = true;
          flags = "-k -p --utc";
          frequent = 4;
          hourly = 24;
          daily = 7;
          weekly = 4;
          monthly = 12;
        };
        trim = {
          enable = true;
          interval = "weekly";
          randomizedDelaySec = "2h";
        };
      };
    };
  };
}

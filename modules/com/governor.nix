{config, ...}: {
  flake.nixosModules.governor = {
    powerManagement = {
      cpuFreqGovernor =
        if config.networking.hostName == "yggdrasil"
        then "performance"
        else "powersave";
    };
  };
}

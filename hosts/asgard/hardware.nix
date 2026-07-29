{
  flake.nixosModules.asgardHardware = {modulesPath, config, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    fileSystems."/srv" = {
      device = "/dev/sde1";
      fsType = "xfs";
    };
    networking.hostName = "asgard";
    system.stateVersion = config.asgard.state;
  };
}

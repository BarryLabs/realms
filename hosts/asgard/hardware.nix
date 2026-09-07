{
  flake.nixosModules.asgardHardware = {
    modulesPath,
    config,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    ### Attached Disks
    fileSystems."/srv" = {
      device = "/dev/sde1";
      fsType = "xfs";
    };
    ### Setup
    networking.hostName = "asgard";
    system.stateVersion = config.asgard.state;
  };
}

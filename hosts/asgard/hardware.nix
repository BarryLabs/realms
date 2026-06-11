{
  flake.nixosModules.asgardHardware = {modulesPath, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    fileSystems."/srv" = {
      device = "/dev/sde1";
      fsType = "xfs";
    };
    networking.hostName = "asgard";
  };
}

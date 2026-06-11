{
  flake.nixosModules.orcaHardware = {modulesPath, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    networking.hostName = "orca";
  };
}

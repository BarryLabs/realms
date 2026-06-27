{
  flake.nixosModules.aegirHardware = {modulesPath, config, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    ### Disks
    # fileSystems."/srv" = {
    #   device = "/dev/sde1";
    #   fsType = "xfs";
    # };
    ### Networking
    networking.hostName = "aegir";
    ### State
    system.stateVersion = config.aegir.state;
  };
}

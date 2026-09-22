{
  flake.nixosModules.bifrostHardware = {modulesPath, config, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    ### Hostname
    networking.hostName = "bifrost";
    
    ### State
    system.stateVersion = config.bifrost.state;
  };
}

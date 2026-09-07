{
  flake.nixosModules.aegirHardware = {
    modulesPath,
    config,
    pkgs,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    ### Disks
    # HDD
    boot = {
      initrd.systemd.enable = true;
      kernelModules = ["dm-crypt"];
      supportedFilesystems = ["nfs" "xfs"];
    };
    fileSystems = {
      # "/hdd" = {
      #   device = "/dev/mapper/hdd";
      #   fsType = "xfs";
      #   options = [ "defaults" "noatime" ];
      # };
    };
    # Network Share
    fileSystems = {
      # "/srv" = {
      #   device = "192.168.40.5:/asgard/share/media";
      #   fsType = "nfs";
      #   options = [
      #     "noauto"
      #     "noatime"
      #     "soft"
      #   ];
      # };
    };
    ### Networking
    networking.hostName = "aegir";
    ### State
    system.stateVersion = config.aegir.state;
  };
}

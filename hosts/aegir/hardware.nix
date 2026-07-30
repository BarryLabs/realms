{
  flake.nixosModules.aegirHardware = {modulesPath, config, pkgs, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
    ### Disks
    # HDD
    boot = {
      initrd.systemd.enable = true;
      kernelModules = [ "dm-crypt" ];
      supportedFilesystems = [ "nfs" "xfs" ];
    };
    # environment.etc.crypttab.text = ''
    #   hdd UUID=0f0def17-09e3-41ff-bb64-2d2ffe23b8e4 /root/.config/secrets/hdd.key luks,discard
    # '';
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

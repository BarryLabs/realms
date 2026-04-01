{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];
  fileSystems."/srv" = {
     device = "/dev/sde1";
     fsType = "xfs";
  };
  augs = {
    backup.asgard.enable = true;
    profile = {
      server.enable = true;
      # monitoring.enable = true;
    };
    com = {
      bootGRUB.enable = true;
      intelGPU.enable = true;
      nh.enable = true;
      podman.enable = true;
      sops.enable = true;
      zfs.enable = true;
      zram.enable = true;
    };
    svc = {
      nfsv4.enable = true;
    };
    oci = {
      pgadmin.enable = true;
      filebrowser.enable = true;
      firefly.enable = true;
      forgejo.enable = true;
      immich.enable = true;
      linkwarden.enable = true;
      paperless.enable = true;
      romm.enable = true;
      rustfs.enable = true;
      syncthing.enable = true;
      vaultwarden.enable = true;
    };
  };
}

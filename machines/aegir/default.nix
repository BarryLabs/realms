{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];

  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/srv" = {
    device = "192.168.40.5:/asgard/share/media";
    fsType = "nfs";
  };

  augs = {
    profile = {
      server.enable = true;
      monitoring.enable = true;
    };
    com = {
      bootGRUB.enable = true;
      intelGPU.enable = true;
      nvidiaGPU.enable = true;
      nh.enable = true;
      podman.enable = true;
      sops.enable = true;
    };
    oci = {
      jellyseerr.enable = true;
      jellyfin.enable = true;
      prowlarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;
      torrent.enable = true;
    };
  };

  sops = {
    secrets = {
      tz = {
        mode = "0400";
      };
    };
  };
}

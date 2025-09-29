{ pkgs
, ...
}:
{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    borg.asgard.enable = false;
    sync.asgard.enable = false;
    com = {
      bash.enable = true;
      bootGRUB.enable = true;
      docs.enable = true;
      environment.enable = true;
      kernel.enable = true;
      locale.enable = true;
      network.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      openssh.enable = true;
      qemuguest.enable = true;
      sops.enable = false;
      state.enable = true;
      timezone.enable = true;
      users.enable = true;
      zfs.enable = true;
    };
    services = {
      promtail.enable = false;
      node-exporter.enable = false;
      database.enable = false;
      gitea.enable = false;
      nextcloud.enable = false;
    };
    oci = {
      immich.enable = false;
      paperless.enable = false;
    };
  };

  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [
        80
        2283
        3000
        8000
        8384
      ];
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-sdk
        intel-media-driver
        intel-vaapi-driver
        intel-compute-runtime
        vaapiVdpau
        vpl-gpu-rt
      ];
    };
  };

  # sops = {
  #   secrets = {
  #     localVoidEncKey = {
  #       mode = "0440";
  #     };
  #     remoteVoidEncKey = {
  #       mode = "0440";
  #     };
  #     pgAdminKey = {
  #       mode = "0440";
  #       owner = config.users.users.pgadmin.name;
  #       group = config.users.users.pgadmin.group;
  #       restartUnits = ["pgadmin.service"];
  #     };
  #     GiteaDBKey = {
  #       mode = "0440";
  #       owner = config.users.users.gitea.name;
  #       group = config.users.users.gitea.group;
  #       restartUnits = ["gitea.service"];
  #     };
  #     NextcloudAdminKey = {
  #       mode = "0440";
  #       owner = "nextcloud";
  #       group = "nextcloud";
  #       restartUnits = ["nextcloud-cron.timer" "nextcloud-update-db.service" "redis-nextcloud.service" "nginx.service" "phpfpm-nextcloud.service" "system-phpfpm.slice"];
  #     };
  #     NextcloudDBKey = {
  #       mode = "0440";
  #       owner = "nextcloud";
  #       group = "nextcloud";
  #       restartUnits = ["nextcloud-cron.timer" "nextcloud-update-db.service" "redis-nextcloud.service" "nginx.service" "phpfpm-nextcloud.service" "system-phpfpm.slice"];
  #     };
  #     SyncthingAdminKey = {
  #       mode = "0440";
  #       owner = "syncthing";
  #       group = "syncthing";
  #       restartUnits = ["syncthing-init.service" "syncthing.service"];
  #     };
  #   };
  # };
}

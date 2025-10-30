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
    backup.asgard.enable = true;
    profile = {
      monitoring.enable = true;
      server.enable = true;
    };
    com = {
      nh.enable = true;
      sops.enable = true;
      zfs.enable = true;
      zram.enable = true;
    };
    oci = {
      filebrowser.enable = true;
      firefly.enable = true;
      forgejo.enable = true;
      immich.enable = true;
      paperless.enable = true;
      pgadmin.enable = false;
      syncthing.enable = true;
    };
  };

  environment = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        intel-compute-runtime
        vaapiVdpau
        vpl-gpu-rt
      ];
    };
  };

  sops = {
    secrets = {
      "services/pgadmin/default_email" = {
        mode = "0400";
      };
      "services/pgadmin/default_pass" = {
        mode = "0400";
      };
      "services/firefly/owner" = {
        mode = "0400";
      };
      "services/firefly/app_key" = {
        mode = "0400";
      };
      "services/firefly/db_port" = {
        mode = "0400";
      };
      "services/firefly/db_name" = {
        mode = "0400";
      };
      "services/firefly/db_user" = {
        mode = "0400";
      };
      "services/firefly/db_pass" = {
        mode = "0400";
      };
      "services/firefly_db/db_name" = {
        mode = "0400";
      };
      "services/firefly_db/db_user" = {
        mode = "0400";
      };
      "services/firefly_db/db_pass" = {
        mode = "0400";
      };
      "services/filebrowser/config" = {
        mode = "0400";
      };
      "services/filebrowser/admin_pass" = {
        mode = "0400";
      };
      "services/paperless/admin_user" = {
        mode = "0400";
      };
      "services/paperless/admin_pass" = {
        mode = "0400";
      };
      "services/paperless/db_host" = {
        mode = "0400";
      };
      "services/paperless/db_pass" = {
        mode = "0400";
      };
      "services/paperless/db_user" = {
        mode = "0400";
      };
      "services/paperless_db/db_name" = {
        mode = "0400";
      };
      "services/paperless_db/db_user" = {
        mode = "0400";
      };
      "services/paperless_db/db_password" = {
        mode = "0400";
      };
      "services/immich/db_name" = {
        mode = "0400";
      };
      "services/immich/db_user" = {
        mode = "0400";
      };
      "services/immich/db_pass" = {
        mode = "0400";
      };
      "services/immich_db/db_name" = {
        mode = "0400";
      };
      "services/immich_db/db_user" = {
        mode = "0400";
      };
      "services/immich_db/db_pass" = {
        mode = "0400";
      };
      "backup/ssh/local" = {
        mode = "0400";
      };
      "backup/ssh/remote" = {
        mode = "0400";
      };
      "backup/repo/local" = {
        mode = "0400";
      };
      "backup/repo/remote" = {
        mode = "0400";
      };
      "backup/key/local" = {
        mode = "0400";
      };
      "backup/key/remote" = {
        mode = "0400";
      };
    };
  };
}

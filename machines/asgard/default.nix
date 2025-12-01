{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
    ../../modules/profile/system
  ];

  augs = {
    backup.asgard.enable = true;
    profile = {
      monitoring.enable = true;
      server.enable = true;
    };
    com = {
      intelGPU.enable = true;
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
      linkwarden.enable = true;
      paperless.enable = true;
      pgadmin.enable = false;
      syncthing.enable = true;
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
      "services/linkwarden/nextauth_key" = {
        mode = "0400";
      };
      "services/linkwarden/meili_key" = {
        mode = "0400";
      };
      "services/linkwarden/db_key" = {
        mode = "0400";
      };
      "services/linkwarden/db_url" = {
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

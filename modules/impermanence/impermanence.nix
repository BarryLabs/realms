{inputs, ...}: {
  flake.nixosModules.impermanence = {
    lib,
    config,
    pkgs,
    ...
  }: let
    cfg = config.persistence;

    nukeRootScript = ''
      mkdir /btrfs_tmp
      mount ${cfg.rootDevice} /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  in {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    config = lib.mkIf cfg.enable {
      fileSystems."/persist".neededForBoot = true;

      programs.fuse.userAllowOther = true;

      boot.tmp.cleanOnBoot = lib.mkDefault true;

      environment.persistence = {
        # "/persist/userdata".users = persistentData;
        # "/persist/usercache".users = persistentCache;

        "/persist/userdata".users."${cfg.user}" = {
          directories = cfg.data.directories;
          files = cfg.data.files;
        };

        "/persist/usercache".users."${cfg.user}" = {
          directories = cfg.cache.directories;
          files = cfg.cache.files;
        };

        "/persist/system" = {
          hideMounts = true;
          directories =
            [
              "/etc/nixos"
              "/var/log"
              "/var/lib/bluetooth"
              "/var/lib/nixos"
              "/var/lib/systemd/coredump"
              "/etc/NetworkManager/system-connections"
            ]
            ++ cfg.directories;
          files =
            [
              "/etc/machine-id"
              {
                file = "/root/.config/sops/age/keys.txt";
                parentDirectory = {mode = "u=rwx,g=,o=";};
              }
            ]
            ++ cfg.files;
        };
      };

      boot.initrd.postDeviceCommands =
        lib.mkIf (!config.boot.initrd.systemd.enable && cfg.nukeRoot.enable)
        (lib.mkAfter nukeRootScript);

      boot.initrd.systemd.services."create-root-subvolume" = lib.mkIf (config.boot.initrd.systemd.enable && cfg.nukeRoot.enable) {
        description = "Create root btrfs subvolume";
        wantedBy = ["initrd-root-device.target"];
        after = ["initrd-root-device.target"];
        before = ["sysroot.mount"];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        path = with pkgs; [btrfs-progs coreutils findutils util-linux];
        script = nukeRootScript;
      };
    };
  };
}

{
  config,
  lib,
  ...
}:
with lib;
let
  module = "btrfsImpermanent";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "btrfsImpermanent Module";
  config = mkIf cfg.enable {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/etc/ssh"
        "/var/log"
        "/var/lib"
        "/home/${config.var.user}"
      ];
      files = [
        "/etc/machine-id"
        "/root/.config/sops/age/keys.txt"
      ];
    };
    boot.initrd.systemd = {
      enable = true;
      services.rollback = {
        description = "Rollback BTRFS Root Subvolume to a Pristine State";
        wantedBy = [ "initrd.target" ];
        after = [
          "systemd-cryptsetup@crypt.service"
          "systemd-cryptsetup@crypted.service"
        ];
        before = [ "sysroot.mount" ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir -p /mnt
          mount -o subvol=/ /dev/mapper/crypt /mnt

          # While we're tempted to just delete /root and create
          # a new snapshot from /root-blank, /root is already
          # populated at this point with a number of subvolumes,
          # which makes `btrfs subvolume delete` fail.
          # So, we remove them first.
          #
          # /root contains subvolumes:
          # - /root/var/lib/portables
          # - /root/var/lib/machines

          btrfs subvolume list -o /mnt/root |
            cut -f9 -d' ' |
            while read subvolume; do
              echo "deleting /$subvolume subvolume..."
              btrfs subvolume delete "/mnt/$subvolume"
            done &&
            echo "deleting /root subvolume..." &&
            btrfs subvolume delete /mnt/root
          echo "restoring blank /root subvolume..."
          btrfs subvolume snapshot /mnt/root-blank /mnt/root

          umount /mnt
        '';
      };
    };
  };
}

{config, ...}: {
  flake.nixosModules.longhorn = {pkgs, ...}: {
    boot.supportedFilesystems = ["nfs"];
    environment = {
      sessionVariables = {
        "PATH" = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
      };
      systemPackages = [pkgs.nfs-utils];
    };
    services = {
      rpcbind.enable = true;
      openiscsi = {
        enable = true;
        name = "${config.networking.hostName}-initiatorhost";
      };
    };
  };
}

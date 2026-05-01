{lib, ...}: {
  flake.nixosModules.settings = {
    documentation.enable = false;
    systemd.coredump.enable = true;
    services.logrotate.checkConfig = lib.mkDefault false;
  };
}

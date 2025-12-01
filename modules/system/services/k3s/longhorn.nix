{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "longhorn";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Longhorn Module";
  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "nfs" ];
    environment = {
      sessionVariables = {
        "PATH" =
          "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin";
      };
      systemPackages = [ pkgs.nfs-utils ];
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

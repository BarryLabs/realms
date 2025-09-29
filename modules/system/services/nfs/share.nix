{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.nfs.srv;
in
{
  options.augs.services.nfs.srv.enable = mkEnableOption "NFS Module for Realms";
  config = mkIf cfg.enable {
    system = {
      activationScripts = {
        "nfsBuilder" = ''
          install -d -m 600 /nfs -o nobody -g nogroup
        '';
      };
    };
    networking.firewall.allowedTCPPorts = [ 2049 ];
    fileSystems = {
      "/nfs/family" = {
        options = [ "bind" ];
        device = "/zpool/nfs/family";
      };
      "/nfs/yggdrasil" = {
        options = [ "bind" ];
        device = "/zpool/nfs/yggdrasil";
      };
    };
    services = {
      nfs = {
        server = {
          enable = true;
          exports = ''
            /nfs              192.168.1.235(fsid=0,no_subtree_check,rw,insecure)
            /nfs/family       192.168.1.1/24(no_subtree_check,rw,sync,insecure)
            /nfs/yggdrasil    192.168.1.235(no_subtree_check,rw,sync,insecure)
          '';
        };
      };
    };
  };
}

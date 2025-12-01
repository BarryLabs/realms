{ config
, lib
, ...
}:
with lib; let
  module = "smb";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "SMB Module";
  config = mkIf cfg.enable {
    systemd.tmpfiles.rules = [ "d /public 0755 share users" ];
    users.users.share = {
      isNormalUser = false;
    };
    services = {
      samba = {
        enable = true;
        enableNmbd = true;
        extraConfig = ''
          dns proxy = no
          workgroup = WORKGROUP
          log file = /var/log/samba/smbd.%m
          max log size = 50
          map to guest = Bad User
          server role = standalone server
          server string = Samba Server
        '';
        shares = {
          public = {
            path = "/public";
            browseable = "yes";
            "public" = "yes";
            "writable" = "yes";
            "guest ok" = "yes";
            "force user" = "share";
          };
        };
      };
    };
  };
}

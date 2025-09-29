{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.openssh;
in
{
  options.augs.com.openssh.enable = mkEnableOption "Base SSH Module";
  config = mkIf cfg.enable {
    security.pam.services = {
      sshd.enableAppArmor = if config.augs.com.apparmor.enable then true else false;
    };
    services = {
      openssh = {
        enable = true;
        startWhenNeeded = true;
        settings = {
          PermitRootLogin = lib.mkDefault "no";
          PasswordAuthentication = lib.mkDefault false;
        };
      };
    };
  };
}

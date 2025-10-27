{ config
, lib
, ...
}:
with lib;
let
  module = "openssh";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base SSH Module";
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

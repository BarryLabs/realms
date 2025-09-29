{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.sudo-rs;
in
{
  options.augs.com.sudo-rs.enable = mkEnableOption "Base Sudo-rs Module";
  config = mkIf cfg.enable {
    security = {
      pam.services = {
        sudo-rs.enableAppArmor = if config.augs.com.apparmor.enable then true else false;
      };
      sudo = {
        enable = false;
      };
      sudo-rs = {
        enable = true;
        execWheelOnly = true;
      };
    };
  };
}

{ config
, lib
, ...
}:
with lib;
let
  module = "sudo-rs";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Sudo-rs Module";
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

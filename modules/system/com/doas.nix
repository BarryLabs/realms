{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.doas;
in
{
  options.augs.com.doas.enable = mkEnableOption "Base Doas Module";
  config = mkIf cfg.enable {
    security = {
      pam.services = {
        doas.enableAppArmor = if config.augs.com.apparmor.enable then true else false;
      };
      sudo = {
        enable = false;
      };
      doas = {
        enable = true;
        extraRules = [
          {
            groups = [ "doas" ];
            noPass = false;
            keepEnv = true;
          }
        ];
      };
    };
  };
}

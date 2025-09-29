{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.com.apparmor;
in
{
  options.augs.com.apparmor.enable = mkEnableOption "Base AppArmor Module";
  config = mkIf cfg.enable {
    security = {
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
        packages = with pkgs; [
          apparmor-utils
          apparmor-profiles
        ];
      };
    };
  };
}

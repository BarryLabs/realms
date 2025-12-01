{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "apparmor";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base AppArmor Module";
  config = mkIf cfg.enable {
    security = {
      ${module} = {
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

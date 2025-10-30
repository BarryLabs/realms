{ config
, lib
, ...
}:
with lib;
let
  module = "virtualisation";
  cfg = config.augs.profile.${module};
in
{
  imports = [
    ../../../system
  ];
  options.augs.profile.${module}.enable = mkEnableOption "Virtualisation Profile";
  config = mkIf cfg.enable {
    augs = {
      com = {
        virt-manager.enable = true;
        waydroid.enable = true;
      };
    };
  };
}

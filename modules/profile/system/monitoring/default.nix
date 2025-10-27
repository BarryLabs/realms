{ config
, lib
, ...
}:
with lib;
let
  module = "monitoring";
  cfg = config.augs.profile.${module};
in
{
  imports = [
    ../../../system
  ];
  options.augs.profile.${module}.enable = mkEnableOption "Base Monitoring Profile";
  config = mkIf cfg.enable {
    augs = {
      services = {
        node-exporter.enable = true;
        promtail.enable = true;
      };
    };
  };
}

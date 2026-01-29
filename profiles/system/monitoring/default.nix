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
    ../../../modules/system
  ];
  options.augs.profile.${module}.enable = mkEnableOption "Monitoring Profile";
  config = mkIf cfg.enable {
    augs = {
      svc = {
        node-exporter.enable = true;
        promtail.enable = true;
      };
    };
  };
}

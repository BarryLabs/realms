{ config
, lib
, ...
}:
with lib; let
  module = "loki";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Loki Module";
  config = mkIf cfg.enable {
    services = {
      loki = {
        enable = true;
        configFile = ./loki.yaml;
      };
    };
  };
}

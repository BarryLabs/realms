{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.loki;
in
{
  options.augs.services.loki.enable = mkEnableOption "Base Loki Module";
  config = mkIf cfg.enable {
    services = {
      loki = {
        enable = true;
        configFile = ./loki.yaml;
      };
    };
  };
}

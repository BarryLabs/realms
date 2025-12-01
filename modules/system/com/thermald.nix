{ config
, lib
, ...
}:
with lib;
let
  module = "thermald";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Thermald Module";
  config = mkIf cfg.enable {
    services.thermald = {
      enable = true;
    };
  };
}

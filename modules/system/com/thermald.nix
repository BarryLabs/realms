{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.thermald;
in
{
  options.augs.com.thermald.enable = mkEnableOption "Base Thermald Module";
  config = mkIf cfg.enable {
    services.thermald = {
      enable = true;
    };
  };
}

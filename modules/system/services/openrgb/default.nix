{ config
, lib
, ...
}:
with lib; let
  module = "openrgb";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "OpenRGB Module";
  config = mkIf cfg.enable {
    services = {
      hardware = {
        openrgb = {
          enable = true;
        };
      };
    };
  };
}

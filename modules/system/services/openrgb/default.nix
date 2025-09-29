{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.openrgb;
in
{
  options.augs.services.openrgb.enable = mkEnableOption "Base OpenRGB Module";
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

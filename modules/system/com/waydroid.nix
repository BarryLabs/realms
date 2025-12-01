{ config
, lib
, ...
}:
with lib; let
  module = "waydroid";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Waydroid Module";
  config = mkIf cfg.enable {
    virtualisation = {
      waydroid = {
        enable = true;
      };
    };
  };
}

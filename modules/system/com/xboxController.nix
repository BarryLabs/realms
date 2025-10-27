{ config
, lib
, ...
}:
with lib;
let
  module = "xboxController";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Xbox Controller Module";
  config = mkIf cfg.enable {
    hardware = {
      xone = {
        enable = true;
      };
    };
  };
}

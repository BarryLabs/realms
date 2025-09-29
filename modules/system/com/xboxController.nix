{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.xboxController;
in
{
  options.augs.com.xboxController.enable = mkEnableOption "Base Xbox Controller Module";
  config = mkIf cfg.enable {
    hardware = {
      xone = {
        enable = true;
      };
    };
  };
}

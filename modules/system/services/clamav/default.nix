{ config
, lib
, ...
}:
with lib;
let
  module = "clamav";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "ClamAV Module";
  config = mkIf cfg.enable {
    services.clamav = {
      daemon.enable = true;
      fangfrisch = {
        enable = true;
        interval = "daily";
      };
      updater = {
        enable = true;
        frequency = 12;
        interval = "daily";
      };
      scanner = {
        enable = true;
        interval = "Sat *-*-* 04:00:00";
      };
    };
  };
}

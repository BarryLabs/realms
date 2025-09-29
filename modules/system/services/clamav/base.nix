{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.clamav;
in
{
  options.augs.services.clamav.enable = mkEnableOption "Base ClamAV Module";
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

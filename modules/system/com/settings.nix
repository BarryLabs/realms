{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.settings;
in
{
  options.augs.com.settings.enable = mkEnableOption "Base Settings Module";
  config = mkIf cfg.enable {
    documentation.enable = false;
    systemd.coredump.enable = true;
    services.logrotate.checkConfig = false;
  };
}

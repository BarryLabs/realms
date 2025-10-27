{ config
, lib
, ...
}:
with lib;
let
  module = "settings";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Settings Module";
  config = mkIf cfg.enable {
    documentation.enable = false;
    systemd.coredump.enable = true;
    services.logrotate.checkConfig = false;
  };
}

{ config
, lib
, ...
}:
with lib;
let
  module = "timezone";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Timezone Module";
  config = mkIf cfg.enable {
    time = {
      hardwareClockInLocalTime = true;
      timeZone = lib.mkDefault config.var.timezone;
    };
  };
}

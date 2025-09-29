{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.timezone;
in
{
  options.augs.com.timezone.enable = mkEnableOption "Base Timezone Module";
  config = mkIf cfg.enable {
    time = {
      hardwareClockInLocalTime = true;
      timeZone = lib.mkDefault config.var.timezone;
    };
  };
}

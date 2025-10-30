{ config
, lib
, ...
}:
with lib; let
  module = "wlsunset";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "WLSunset Module";
  config = mkIf cfg.enable {
    services = {
      wlsunset = {
        enable = true;
        sunrise = "06:00";
        sunset = "21:00";
        temperature = {
          day = 2550;
          night = 2500;
        };
      };
    };
  };
}

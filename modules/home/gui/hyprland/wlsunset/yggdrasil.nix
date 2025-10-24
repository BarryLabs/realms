{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.mods.wm.wayland.wlsunset.yggdrasil;
in {
  options.mods.wm.wayland.wlsunset.yggdrasil.enable = mkEnableOption "enable wlsunset for yggdrasil";
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

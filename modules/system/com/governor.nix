{ config
, lib
, ...
}:
with lib; let
  module = "governor";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base CPU Governor Module";
  config = mkIf cfg.enable {
    powerManagement = {
      cpuFreqGovernor =
        if config.networking.hostName == "yggdrasil"
        then lib.mkDefault "performance"
        else lib.mkDefault "powersave";
    };
  };
}

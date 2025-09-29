{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.governor;
in
{
  options.augs.com.governor.enable = mkEnableOption "Base CPU Governor Module";
  config = mkIf cfg.enable {
    powerManagement = {
      cpuFreqGovernor =
        if config.networking.hostName == "yggdrasil"
        then lib.mkDefault "performance"
        else lib.mkDefault "powersave";
    };
  };
}

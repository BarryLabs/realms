{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.cpu;
in
{
  options.augs.com.cpu.enable = mkEnableOption "Base CPU Module";
  config = mkIf cfg.enable {
    hardware = {
      cpu = {
        amd = {
          updateMicrocode =
            if config.networking.hostName == "yggdrasil"
            then lib.mkDefault config.hardware.enableRedistributableFirmware
            else false;
        };
        intel = {
          updateMicrocode =
            if config.networking.hostName == "yggdrasil"
            then false
            else lib.mkDefault config.hardware.enableRedistributableFirmware;
        };
      };
    };
  };
}

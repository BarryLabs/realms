{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.nvidiaGPU;
in
{
  options.augs.com.nvidiaGPU.enable = mkEnableOption "Nvidia GPU Module for Realms";
  config = mkIf cfg.enable {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        open = false;
        nvidiaSettings = true;
        modesetting = {
          enable = true;
        };
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        prime =
          if config.networking.hostName == "abyss"
          then {
            intelBusId = config.var.i630Id;
            nvidiaBusId = config.var.d1660Id;
            sync = {
              enable = true;
            };
            #offload = {
            #  enable = true;
            #  enableOffloadCmd = true;
            #};
          }
          else { };
      };
    };
  };
}

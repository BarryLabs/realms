{ config
, lib
, ...
}:
with lib;
let
  module = "xserver";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Xserver Module";
  config = mkIf cfg.enable {
    services = {
      xserver = {
        videoDrivers = if config.augs.com.nvidiaGPU.enable then [ "nvidia" ] else [ "rocm" ];
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}

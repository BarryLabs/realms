{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "intelGPU";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Intel GPU Module";
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [
      "modesetting"
    ];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
    };
  };
}

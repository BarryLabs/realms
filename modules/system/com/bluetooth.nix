{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "bluetooth";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Bluetooth Module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bluetui
    ];
    hardware.${module} = {
      enable = true;
      powerOnBoot = true;
    };
  };
}

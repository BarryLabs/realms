{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.com.bluetooth;
in
{
  options.augs.com.bluetooth.enable = mkEnableOption "Base Bluetooth Module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bluetui
    ];
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}

{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "udisks";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Udisks Module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      usbutils
    ];
    services.udisks2 = {
      enable = true;
    };
    # services.usbguard = {
    #   enable = true;
    #   dbus.enable = true;
    #   implicitPolicyTarget = "block";
    #   # FIXME: set yours pref USB devices (change {id} to your trusted USB device), use `lsusb` command (from usbutils package) to get list of all connected USB devices including integrated devices like camera, bluetooth, wifi, etc. with their IDs or just disable `usbguard`
    #   rules = ''
    #     allow id {id} # device 1
    #     allow id {id} # device 2
    #   '';
    # };
  };
}

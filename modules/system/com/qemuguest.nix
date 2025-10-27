{ config
, lib
, modulesPath
, ...
}:
with lib; let
  module = "qemuguest";
  cfg = config.augs.com.${module};
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];
  options.augs.com.${module}.enable = mkEnableOption "Base QemuGuest Module";
  config = mkIf cfg.enable {
    services = {
      qemuGuest = {
        enable = true;
      };
    };
  };
}

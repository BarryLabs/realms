{ config
, lib
, ...
}:
with lib; let
  module = "bootEFI";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base BootEFI Module";
  config = mkIf cfg.enable {
    boot = {
      loader = {
        timeout = 3;
        systemd-boot = {
          enable = true;
        };
        efi = {
          canTouchEfiVariables = true;
        };
      };
    };
  };
}

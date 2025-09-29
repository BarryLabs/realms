{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.bootEFI;
in
{
  options.augs.com.bootEFI.enable = mkEnableOption "Base BootEFI Module";
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

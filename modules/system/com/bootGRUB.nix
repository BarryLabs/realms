{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.bootGRUB;
in
{
  options.augs.com.bootGRUB.enable = mkEnableOption "Base BootGrub Module";
  config = mkIf cfg.enable {
    boot = {
      loader = {
        timeout = 3;
        grub = {
          enable = true;
          useOSProber = true;
        };
      };
    };
  };
}

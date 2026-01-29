{
  config,
  lib,
  ...
}:
with lib;
let
  module = "bootGRUB";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Grub Module";
  config = mkIf cfg.enable {
    boot = {
      loader = {
        timeout = 5;
        grub = {
          enable = true;
          useOSProber = true;
        };
      };
    };
  };
}

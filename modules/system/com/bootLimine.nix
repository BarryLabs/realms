{
  config,
  lib,
  ...
}:
with lib;
let
  module = "bootLimine";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Limine Module";
  config = mkIf cfg.enable {
    boot = {
      loader = {
        timeout = 5;
        limine = {
          enable = true;
        };
      };
    };
  };
}

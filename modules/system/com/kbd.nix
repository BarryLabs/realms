{ config
, lib
, ...
}:
with lib;
let
  module = "kbd";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base KBD Module";
  config = mkIf cfg.enable {
    services = {
      xserver = {
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}

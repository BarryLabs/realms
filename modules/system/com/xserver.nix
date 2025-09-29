{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.xserver;
in
{
  options.augs.com.xserver.enable = mkEnableOption "Base Xserver Module";
  config = mkIf cfg.enable {
    services = {
      xserver = {
        videoDrivers = [ "nvidia" ];
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}

{ config
, lib
, ...
}:
with lib; let
  module = "fstrim";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "fsTrim Module";
  config = mkIf cfg.enable {
    services = {
      fstrim = {
        enable = true;
        interval = lib.mkDefault "weekly";
      };
    };
  };
}

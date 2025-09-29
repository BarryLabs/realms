{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.com.fstrim;
in
{
  options.augs.com.fstrim.enable = mkEnableOption "Base FsTrim Module";
  config = mkIf cfg.enable {
    services = {
      fstrim = {
        enable = true;
        interval = lib.mkDefault "weekly";
      };
    };
  };
}

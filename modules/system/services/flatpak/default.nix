{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.flatpak;
in
{
  options.augs.services.flatpak.enable = mkEnableOption "Base Flatpak Module";
  config = mkIf cfg.enable {
    services = {
      flatpak = {
        enable = true;
      };
    };
  };
}

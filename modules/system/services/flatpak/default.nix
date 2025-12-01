{ config
, lib
, ...
}:
with lib; let
  module = "flatpak";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Flatpak Module";
  config = mkIf cfg.enable {
    services = {
      flatpak.enable = true;
    };
  };
}

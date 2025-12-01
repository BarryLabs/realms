{ config
, lib
, ...
}:
with lib;
let
  module = "hyprpolkit";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Hyprpolkit Module";
  config = mkIf cfg.enable {
    services.hyprpolkitagent = {
      enable = true;
    };
  };
}

{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.wm.wayland.hyprpolkit.yggdrasil;
in
{
  options.mods.wm.wayland.hyprpolkit.yggdrasil.enable = mkEnableOption "Hyprpolkit Module";
  config = mkIf cfg.enable {
    services.hyprpolkitagent = {
      enable = true;
    };
  };
}

{
  config,
  lib,
  ...
}:
with lib;
let
  module = "quickshell";
  cfg = config.mods.gui.${module};
in
{
  options.mods.gui.${module}.enable = mkEnableOption "Quickshell Module";
  config = mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
    };
  };
}

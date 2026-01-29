{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "zed";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Zed Module";
  config = mkIf cfg.enable {
    programs = {
      zed-editor = {
        enable = true;
      };
    };
  };
}

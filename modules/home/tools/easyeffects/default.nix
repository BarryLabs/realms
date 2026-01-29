{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "easyeffects";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Easyeffects Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      easyeffects
    ];
  };
}

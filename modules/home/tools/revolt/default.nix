{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "revolt";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Revolt Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      revolt-desktop
    ];
  };
}

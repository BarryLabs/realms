{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "freetube";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Freetube Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      freetube
    ];
  };
}

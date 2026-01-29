{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "gamescope";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Gamescope Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gamescope
    ];
  };
}

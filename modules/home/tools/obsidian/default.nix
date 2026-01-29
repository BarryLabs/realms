{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "obsidian";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Obsidian Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}

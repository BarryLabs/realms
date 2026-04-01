{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "eza";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Eza Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eza
    ];
  };
}

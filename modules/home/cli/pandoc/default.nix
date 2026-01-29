{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "pandoc";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Pandoc Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pandoc
    ];
  };
}

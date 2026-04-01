{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "helix";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Helix Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      helix
    ];
  };
}

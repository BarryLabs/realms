{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "bat";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Bat Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
    ];
  };
}

{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "goose-cli";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Goose CLI Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      goose-cli
    ];
  };
}

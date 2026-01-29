{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "ranger";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Ranger Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ranger
    ];
  };
}

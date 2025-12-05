{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "stow";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Stow Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      stow
    ];
  };
}

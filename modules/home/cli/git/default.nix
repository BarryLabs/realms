{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "git";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Git Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      git
    ];
  };
}

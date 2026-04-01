{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "fzf";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "FZF Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
      fzf
    ];
  };
}

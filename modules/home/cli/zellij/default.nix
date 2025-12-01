{ config
, lib
, ...
}:
with lib;
let
  module = "zellij";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Zellij Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
      };
    };
    home.file."${module}" = {
      recursive = true;
      source = ./layouts;
      target = ".config/${module}/layouts";
    };
  };
}

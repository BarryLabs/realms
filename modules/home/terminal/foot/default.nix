{ config
, lib
, ...
}:
with lib;
let
  module = "foot";
  cfg = config.mods.terminal.${module};
in
{
  options.mods.terminal.${module}.enable = mkEnableOption "Foot Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        server = {
          enable = true;
        };
      };
    };
  };
}

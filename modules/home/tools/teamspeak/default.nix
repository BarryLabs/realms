{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "teamspeak";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Teamspeak6 Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      teamspeak6-client
    ];
  };
}

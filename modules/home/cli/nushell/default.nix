{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "nushell";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Nushell Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      unixtools.netstat
      nushell
    ];
  };
}

{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "kicad";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Ghidra Module";
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.kicad
    ];
  };
}

{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "nautilus";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Nautilus Module";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.nautilus ];
  };
}

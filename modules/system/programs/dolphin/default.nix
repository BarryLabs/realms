{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "dolphin";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Dolphin Module";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.kdePackages.${module} pkgs.kdePackages.dolphin-plugins ];
  };
}

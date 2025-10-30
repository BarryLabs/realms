{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "bat";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Bat Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batman
          batwatch
          batpipe
          prettybat
        ];
      };
    };
  };
}

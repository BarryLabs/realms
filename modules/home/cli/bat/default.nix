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
  options.mods.cli.${module}.enable = mkEnableOption "Bat Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
    ];
    #programs = {
    #  ${module} = {
    #    enable = true;
    #    extraPackages = with pkgs.bat-extras; [
    #      batdiff
    #      batman
    #      batwatch
    #      batpipe
    #      prettybat
    #    ];
    #  };
    #};
  };
}

{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "crypto";
  cfg = config.mods.profile.${module};
in
{
  imports = [
    ../../../modules/home
  ];
  options.mods.profile.${module}.enable = mkEnableOption "Crypto Profile";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      monero-gui
    ];
  };
}

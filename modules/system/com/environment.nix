{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "environment";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Environment Module";
  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        git
        htop
      ];
    };
  };
}

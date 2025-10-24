{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "thunar";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Thunar Module";
  config = mkIf cfg.enable {
    programs.${module} = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
  };
}

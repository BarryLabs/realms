{ config
, lib
, ...
}:
with lib; let
  module = "zsh";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Zsh Module";
  config = mkIf cfg.enable {
    programs = {
      zsh = {
        enable = true;
      };
    };
  };
}

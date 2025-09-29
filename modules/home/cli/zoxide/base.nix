{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.cli.zoxide.base;
in
{
  options.mods.cli.zoxide.base.enable = mkEnableOption "Base Zoxide Module";
  config = mkIf cfg.enable {
    programs = {
      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
  };
}

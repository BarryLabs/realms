{ config
, lib
, ...
}:
with lib;
let
  cfg = config.mods.cli.carapace.base;
in
{
  options.mods.cli.carapace.base.enable = mkEnableOption "Base Carapace Module";
  config = mkIf cfg.enable {
    programs = {
      carapace = {
        enable = true;
      };
    };
  };
}

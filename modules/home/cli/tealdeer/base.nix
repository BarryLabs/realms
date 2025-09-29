{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.cli.tealdeer.base;
in
{
  options.mods.cli.tealdeer.base.enable = mkEnableOption "Base Tealdeer Module";
  config = mkIf cfg.enable {
    programs = {
      tealdeer = {
        enable = true;
        settings = {
          updates = {
            auto_update = true;
            auto_update_interval_hours = 12;
          };
          display = {
            use_pager = true;
          };
        };
      };
    };
  };
}

{ config
, lib
, ...
}:
with lib; let
  module = "tealdeer";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Tealdeer Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        settings = {
          display = {
            use_pager = true;
          };
          updates = {
            auto_update = true;
            auto_update_interval_hours = 12;
          };
        };
      };
    };
  };
}

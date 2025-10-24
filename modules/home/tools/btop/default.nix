{ config
, lib
, ...
}:
with lib; let
  module = "btop";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Base Btop Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/btop"
    #   ];
    # };
    programs = {
      btop = {
        enable = true;
        settings = {
          # color_theme = "dracula";
          vim_keys = true;
          update_ms = 200;
          disks_filter = "";
          mem_graphs = true;
          proc_per_core = true;
        };
      };
    };
  };
}

{ config
, lib
, ...
}:
with lib;
let
  module = "foot";
  cfg = config.mods.terminal.${module};
in
{
  options.mods.terminal.${module}.enable = mkEnableOption "Base Foot Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/foot"
    #   ];
    # };
    programs = {
      ${module} = {
        enable = true;
        server = {
          enable = true;
        };
      };
    };
  };
}

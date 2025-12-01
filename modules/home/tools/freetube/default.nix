{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "freetube";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Base Freetube Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/Freetube"
    #   ];
    # };
    home.packages = with pkgs; [
      freetube
    ];
  };
}

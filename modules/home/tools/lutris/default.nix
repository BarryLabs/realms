{ lib
, config
, pkgs
, ...
}:

with lib;
let
  module = "lutris";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "Base Lutris Module";
  config = mkIf cfg.enable {
    home = {
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
      };
      # persistence."/nix/persist/home" = {
      #   directories = [
      #     ".local/share/lutris"
      #     ".local/share/net.lutris.Lutris"
      #   ];
      # };
    };
    home.packages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          adwaita-icon-theme
          proton-ge-bin
        ];
      })
    ];
  };
}

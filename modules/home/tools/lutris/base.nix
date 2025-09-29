{ lib
, config
, pkgs
, ...
}:

with lib;
let
  cfg = config.mods.tools.lutris.adwaita;
in
{
  options.mods.tools.lutris.adwaita.enable = mkEnableOption "Base Lutris Module";
  config = mkIf cfg.enable {
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };
    home.packages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          adwaita-icon-theme
        ];
      })
    ];
  };
}

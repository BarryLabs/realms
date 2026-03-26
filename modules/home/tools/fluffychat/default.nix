{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "fluffychat";
  cfg = config.mods.tools.${module};
in
{
  options.mods.tools.${module}.enable = mkEnableOption "FluffyChat Module";
  config = mkIf cfg.enable {
    services.gnome-keyring.enable = true;
    home.packages = with pkgs; [
      gcr
      fluffychat
    ];
  };
}

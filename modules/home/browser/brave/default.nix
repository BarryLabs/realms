{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "brave";
  cfg = config.mods.browser.${module};
in
{
  options.mods.browser.${module}.enable = mkEnableOption "Brave Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brave
    ];
  };
}

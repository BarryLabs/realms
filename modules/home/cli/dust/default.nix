{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "dust";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Dust Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      dust
    ];
  };
}

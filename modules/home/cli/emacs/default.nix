{
  config,
  lib,
  ...
}:
with lib;
let
  module = "emacs";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Emacs Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      emacs
    ];
  };
}

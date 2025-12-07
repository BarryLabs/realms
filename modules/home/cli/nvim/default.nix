{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "nvim";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Neovim Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      gcc
    ];
  };
}

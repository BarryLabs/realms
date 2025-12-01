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
    home.file."${module}" = {
      recursive = true;
      source = ./nvim;
      target = ".config/${module}";
    };
    home.packages = with pkgs; [
      neovim
      zig
      rustup
      uv
    ];
  };
}

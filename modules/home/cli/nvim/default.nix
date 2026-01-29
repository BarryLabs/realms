{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "nvim";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Neovim Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      gcc
      tree-sitter
      nodejs-slim
      prettier
      nixfmt
      stylua
      lazygit
      ripgrep
      lua51Packages.lua
      luajitPackages.luarocks
    ];
  };
}

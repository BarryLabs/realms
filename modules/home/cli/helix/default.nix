{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "helix";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Helix Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      marksman
      markdown-oxide
      gopls
      ruff
      zls
    ];
    programs.${module} = {
      enable = true;
      settings = {
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
        {
          name = "go";
          auto-format = true;
          formatter.command = "goimports";
        }
      ];
    };
  };
}

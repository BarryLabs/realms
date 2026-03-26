{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "direnv";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "DirEnv Module";
  config = mkIf cfg.enable {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableBashIntegration = if config.programs.bash.enable then true else false;
        enableZshIntegration = if config.mods.cli.zsh.enable then true else false;
      };
    };
  };
}

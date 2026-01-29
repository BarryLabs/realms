{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  module = "eza";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Eza Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      eza
    ];
    #programs = {
    #  ${module} = {
    #    enable = true;
    #    enableNushellIntegration = if config.mods.cli.nushell.enable then true else false;
    #    enableZshIntegration = if config.mods.cli.zsh.enable then true else false;
    #    colors = "auto";
    #    icons = "auto";
    #    extraOptions = [
    #      "--header"
    #      "--group-directories-first"
    #    ];
    #  };
    #};
  };
}

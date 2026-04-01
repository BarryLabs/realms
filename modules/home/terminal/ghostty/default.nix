{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "ghostty";
  cfg = config.mods.terminal.${module};
in
{
  options.mods.terminal.${module}.enable = mkEnableOption "Ghostty Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];
    # programs = {
    #   ${module} = {
    #     enable = true;
    #     enableBashIntegration = if config.mods.cli.bash.enable then true else false;
    #     enableZshIntegration = if config.mods.cli.zsh.enable then true else false;
    #     installBatSyntax = if config.mods.cli.bat.enable then true else false;
    #     installVimSyntax = true;
    #     settings = {
    #       mouse-hide-while-typing = true;
    #     };
    #   };
    # };
  };
}

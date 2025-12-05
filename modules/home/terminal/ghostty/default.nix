{ config
, lib
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
    programs = {
      ${module} = {
        enable = true;
        enableBashIntegration = if config.mods.cli.bash.base.enable then true else false;
        enableZshIntegration = if config.mods.cli.zsh.base.enable then true else false;
        installBatSyntax = if config.mods.cli.bat.base.enable then true else false;
        installVimSyntax = true;
        settings = {
          mouse-hide-while-typing = true;
        };
      };
    };
  };
}

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
  options.mods.terminal.${module}.enable = mkEnableOption "Base Ghostty Module";
  config = mkIf cfg.enable {
    # home.persistence."/nix/persist/home" = {
    #   directories = [
    #     ".config/ghostty"
    #   ];
    # };
    programs = {
      ${module} = {
        enable = true;
        enableBashIntegration = if config.mods.cli.bash.base.enable then true else false;
        enableZshIntegration = if config.mods.cli.zsh.base.enable then true else false;
        installBatSyntax = if config.mods.cli.bat.base.enable then true else false;
        installVimSyntax = true;
        settings = {
          theme = "catppuccin-mocha";
          font-size = 10;
          mouse-hide-while-typing = true;
          keybind = [
            "ctrl+z=close_surface"
            "ctrl+d=new_split:right"
          ];
        };
      };
    };
  };
}

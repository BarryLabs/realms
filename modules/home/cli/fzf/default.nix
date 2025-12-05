{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "fzf";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "FZF Module";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
      fzf
    ];
    #programs.${module} = {
    #  enable = true;
    #  enableZshIntegration = true;
    #  changeDirWidgetCommand = "fd --type d --exclude .git .jj --follow --hidden";
    #  defaultCommand = "fd --type f --exclude .git --follow --hidden";
    #  defaultOptions = [
    #    "--bind 'ctrl-/:toggle-preview'"
    #    "--preview='bat --color-always -n {}'"
    #  ];
    #};
  };
}

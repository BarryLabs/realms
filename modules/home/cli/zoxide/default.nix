{ config
, lib
, ...
}:
with lib;
let
  module = "zoxide";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Base Zoxide Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        enableNushellIntegration = if config.mods.cli.nushell.enable then true else false;
        enableZshIntegration = if config.mods.cli.zsh.enable then true else false;
      };
    };
  };
}

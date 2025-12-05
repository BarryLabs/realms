{ config
, lib
, ...
}:
with lib;
let
  module = "git";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Git Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        settings = {
          core = {
            editor = "nvim";
            init.defaultBranch = "main";
          };
          user = {
            name = "BarryLabs";
            email = "wave.carton247@aleeas.com";
          };
        };
      };
    };
  };
}

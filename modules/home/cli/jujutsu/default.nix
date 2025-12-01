{ config
, lib
, ...
}:
with lib; let
  module = "jujutsu";
  cfg = config.mods.cli.${module};
in
{
  options.mods.cli.${module}.enable = mkEnableOption "Chandler's Jujutsu Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        ediff = true;
        settings = {
          user = {
            name = "BarryLabs";
            email = "wave.carton247@aleeas.com";
          };
        };
      };
    };
  };
}

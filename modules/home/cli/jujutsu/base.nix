{ config
, lib
, ...
}:
with lib; let
  cfg = config.mods.cli.jujutsu.base;
in
{
  options.mods.cli.jujutsu.base.enable = mkEnableOption "Chandler's Jujutsu Module";
  config = mkIf cfg.enable {
    programs = {
      jujutsu = {
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

{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.programs.weylus;
in
{
  options.augs.programs.weylus.enable = mkEnableOption "Base Weylus Module";
  config = mkIf cfg.enable {
    programs = {
      weylus = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

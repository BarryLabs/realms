{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.programs.alvr;
in
{
  options.augs.programs.alvr.enable = mkEnableOption "Base ALVR Module";
  config = mkIf cfg.enable {
    programs = {
      alvr = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

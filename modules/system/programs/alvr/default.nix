{ config
, lib
, ...
}:
with lib;
let
  module = "alvr";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base ALVR Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

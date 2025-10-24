{ config
, lib
, ...
}:
with lib; let
  module = "weylus";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Base Weylus Module";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

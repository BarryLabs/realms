{ config
, lib
, ...
}:
with lib; let
  module = "appimage";
  cfg = config.augs.programs.${module};
in
{
  options.augs.programs.${module}.enable = mkEnableOption "Appimage Compatibility";
  config = mkIf cfg.enable {
    programs = {
      ${module} = {
        enable = true;
        binfmt = true;
      };
    };
  };
}

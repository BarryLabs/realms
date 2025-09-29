{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.programs.appimages;
in
{
  options.augs.programs.appimages.enable = mkEnableOption "Appimage Compatibility";
  config = mkIf cfg.enable {
    programs = {
      appimage = {
        enable = true;
        binfmt = true;
      };
    };
  };
}

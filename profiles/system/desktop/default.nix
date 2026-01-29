{ config
, lib
, ...
}:
with lib;
let
  module = "desktop";
  cfg = config.augs.profile.${module};
in
{
  imports = [
    ../../../modules/system
  ];
  options.augs.profile.${module}.enable = mkEnableOption "Desktop Profile";
  config = mkIf cfg.enable {
    augs = {
      programs = {
        appimage.enable = true;
        direnv.enable = true;
        firejail.enable = true;
        localsend.enable = true;
        steam.enable = true;
      };
      svc = {
        mullvad.enable = true;
      };
    };
  };
}

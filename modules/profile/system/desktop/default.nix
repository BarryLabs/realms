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
    ../../../system
  ];
  options.augs.profile.${module}.enable = mkEnableOption "Base Desktop Profile";
  config = mkIf cfg.enable {
    augs = {
      programs = {
        alvr.enable = if config.networking.hostName == "yggdrasil" then true else false;
        appimage.enable = true;
        firejail.enable = true;
        kicad.enable = true;
        localsend.enable = true;
        steam.enable = true;
      };
      services = {
        openrgb.enable = if config.networking.hostName == "yggdrasil" then true else false;
        mullvad.enable = true;
      };
    };
  };
}

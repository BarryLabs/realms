{ config
, lib
, ...
}:
with lib; let
  module = "syncthing";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Syncthing Module";
  config = mkIf cfg.enable {
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
    services = {
      syncthing = {
        enable = true;
        systemService = true;
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;
        guiAddress = "0.0.0.0:8384";
        settings = {
          gui = {
            theme = "black";
            user = config.var.user;
            password = config.var.iniPass;
          };
          options = {
            urAccepted = -1;
            localAnnounceEnabled = true;
          };
        };
      };
    };
  };
}

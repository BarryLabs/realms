{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.sync.asgard;
in
{
  options.augs.sync.asgard.enable = mkEnableOption "Syncthing Module for Asgard";
  config = mkIf cfg.enable {
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
    services = {
      syncthing = {
        enable = true;
        openDefaultPorts = true;
        overrideDevices = true;
        overrideFolders = true;
        systemService = true;
        guiAddress = "0.0.0.0:8384";
        settings = {
          gui = {
            theme = "black";
            user = "Asgard";
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

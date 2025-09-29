{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.sync.base;
in
{
  options.augs.sync.base.enable = mkEnableOption "Base Syncthing Module";
  config = mkIf cfg.enable {
    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
    services = {
      syncthing = {
        enable = true;
        user = config.var.user;
        dataDir = "/home/${config.var.user}";
        configDir = "/home/${config.var.user}/.config/syncthing";
        settings = {
          options.urAccepted = -1;
          gui = {
            user = config.var.host;
            password = config.var.iniPass;
          };
        };
      };
    };
  };
}

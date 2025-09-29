{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.services.open-webui;
in
{
  options.augs.services.open-webui.enable = mkEnableOption "Base Open-WebUI Module";
  config = mkIf cfg.enable {
    services.open-webui = {
      enable = true;
      host = "127.0.0.1";
    };
  };
}

{ config
, lib
, ...
}:
with lib;
let
  module = "open-webui";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Open-WebUI Module";
  config = mkIf cfg.enable {
    services.open-webui = {
      enable = true;
      host = "127.0.0.1";
    };
  };
}

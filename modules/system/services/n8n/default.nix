{ config
, lib
, ...
}:
with lib; let
  module = "n8n";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "N8N Module";
  config = mkIf cfg.enable {
    services = {
      n8n = {
        enable = true;
        openFirewall = true;
        #webhookUrl = "";
        settings = { };
      };
    };
  };
}

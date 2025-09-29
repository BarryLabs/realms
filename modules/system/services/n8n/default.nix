{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.n8n;
in
{
  options.augs.services.n8n.enable = mkEnableOption "Base N8N Module";
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

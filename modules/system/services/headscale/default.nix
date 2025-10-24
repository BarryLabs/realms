{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.headscale;
in
{
  options.augs.services.headscale.enable = mkEnableOption "Base Headscale Module";
  config = mkIf cfg.enable {
    services.headscale = {
      enable = true;
      port = 10000;
      address = "0.0.0.0";
      settings = {
        dns = "highrise.mamot.cc";
        server_url = "https://highrise.mamot.cc";
        logtail.enabled = true;
      };
    };
  };
}

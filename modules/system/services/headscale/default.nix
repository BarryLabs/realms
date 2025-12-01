{ config
, lib
, ...
}:
with lib; let
  module = "headscale";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Headscale Module";
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

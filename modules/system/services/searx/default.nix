{ config
, lib
, ...
}:
with lib;
let
  module = "searx";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Searx Module";
  config = mkIf cfg.enable {
    services.searx = {
      enable = true;
      settings = {
        server = {
          port = 7777;
          bind_address = "127.0.0.1";
          secret_key = "@SEARX_SECRET_KEY@";
        };
        search = {
          formats = [
            "html"
            "json"
          ];
        };
      };
    };
  };
}

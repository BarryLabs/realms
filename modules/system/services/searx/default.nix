{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.searx;
in
{
  options.augs.services.searx.enable = mkEnableOption "Base Searx Module";
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

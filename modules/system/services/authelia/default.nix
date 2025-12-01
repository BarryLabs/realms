{ config
, lib
, ...
}:
with lib;
let
  module = "authelia";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Authelia Module";
  config = mkIf cfg.enable {
    services.authelia = { };
  };
}

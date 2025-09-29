{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.authelia;
in
{
  options.augs.services.authelia.enable = mkEnableOption "Base Authelia Module";
  config = mkIf cfg.enable {
    services.authelia = { };
  };
}

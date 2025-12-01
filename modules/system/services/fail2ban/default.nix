{ config
, lib
, ...
}:
with lib;
let
  module = "fail2ban";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Fail2Ban Module";
  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
    };
  };
}

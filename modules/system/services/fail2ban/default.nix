{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.fail2ban;
in
{
  options.augs.services.fail2ban.enable = mkEnableOption "Base Fail2Ban Module";
  config = mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
    };
  };
}

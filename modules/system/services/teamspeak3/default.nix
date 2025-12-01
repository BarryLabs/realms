{ config
, lib
, ...
}:
with lib;
let
  module = "teamspeak";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Teamspeak Module";
  config = mkIf cfg.enable {
    services = {
      teamspeak3 = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

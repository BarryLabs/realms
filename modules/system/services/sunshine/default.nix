{ config
, lib
, ...
}:
with lib; let
  module = "sunshine";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Sunshine Module";
  config = mkIf cfg.enable {
    services = {
      sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
        applications = { };
      };
    };
  };
}

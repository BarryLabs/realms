{ config
, lib
, ...
}:
with lib;
let
  module = "pam";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base PAM Module";
  config = mkIf cfg.enable {
    security = {
      rtkit = {
        enable = true;
      };
      polkit = {
        enable = true;
      };
      pam = {
        services = {
          hyprlock = { };
        };
      };
    };
  };
}

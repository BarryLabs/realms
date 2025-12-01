{ config
, lib
, ...
}:
with lib; let
  module = "home-assistant";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Home-Assistant Module";
  config = mkIf cfg.enable {
    # nixpkgs.config.permittedInsecurePackages = [
    #   "openssl-1.1.1w"
    # ];
    services = {
      home-assistant = {
        enable = true;
        openFirewall = true;
        configWritable = true;
        config = {
          default_config = { };
        };
        extraComponents = [
          "met"
          "esphome"
          "radio_browser"
          "lg_thinq"
        ];
        # extraPackages = ps: with ps; [
        #
        # ];
      };
    };
  };
}

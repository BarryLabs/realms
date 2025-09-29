{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.home-assistant;
in
{
  options.augs.services.home-assistant.enable = mkEnableOption "Home-Assistant Module for Realms";
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

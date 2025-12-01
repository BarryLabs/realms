{ config
, lib
, ...
}:
with lib;
let
  module = "pipewire";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Pipewire Module";
  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [
    #   pavucontrol
    # ];
    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };
  };
}

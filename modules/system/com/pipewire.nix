{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.pipewire;
in
{
  options.augs.com.pipewire.enable = mkEnableOption "Base Pipewire Module";
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

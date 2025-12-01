{ config
, lib
, pkgs
, ...
}:
with lib;
let
  module = "mullvad";
  cfg = config.augs.svc.${module};
in
{
  options.augs.svc.${module}.enable = mkEnableOption "Mullvad Module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mullvad-closest
      mullvad-browser
    ];
    services.mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad;
    };
  };
}

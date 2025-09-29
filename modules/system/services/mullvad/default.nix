{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.services.mullvad;
in
{
  options.augs.services.mullvad.enable = mkEnableOption "Base Mullvad Module";
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

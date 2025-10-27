{ config
, lib
, pkgs
, ...
}:
with lib; let
  module = "mac-randomizer";
  cfg = config.augs.com.${module};
in
{
  options.augs.com.${module}.enable = mkEnableOption "Base Mac Randomizer Module";
  config = mkIf cfg.enable {
    systemd.services.macchanger = {
      enable = true;
      description = "MAC Randomizer";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.macchanger}/bin/macchanger -r wlan0";
        ExecStop = "${pkgs.macchanger}/bin/macchanger -p wlan0";
        RemainAfterExit = true;
      };
    };
  };
}

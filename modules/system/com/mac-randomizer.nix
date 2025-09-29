{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.augs.com.mac-randomizer;
in
{
  options.augs.com.mac-randomizer.enable = mkEnableOption "Base Mac Randomizer Module";
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

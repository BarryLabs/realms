{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.services.teamspeak;
in
{
  options.augs.services.teamspeak.enable = mkEnableOption "Base Teamspeak Module";
  config = mkIf cfg.enable {
    services = {
      teamspeak3 = {
        enable = true;
        openFirewall = true;
        # voiceIP = [];
        # dataDir = "";
        # logPath = "";
        # queryIP = [];
        # queryPort = ;
        # querySshPort = ;
        # queryHttpPort = ;
        # fileTransferIP = [];
        # fileTransferPort = ;
        # defaultVoicePort = ;
        # openFirewallServerQuery = false;
      };
    };
  };
}

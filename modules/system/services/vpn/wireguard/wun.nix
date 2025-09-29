{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.vpn.wireguard.wun;
in
{
  options.augs.vpn.wireguard.wun.enable = mkEnableOption "Wun Wireguard Module";
  config = mkIf cfg.enable {
    networking.wg-quick.interfaces = {
      wg0 = {
        autostart = false;
        configFile = "/root/.config/wg-quick/wun.conf";
        # dns = [];
        # address = [];
        # privateKeyFile = "";
        # peers = [
        #   {
        #     endpoint = "";
        #     publicKey = "";
        #     allowedIPs = [];
        #     presharedKeyFile = "";
        #     persistentKeepalive = 25;
        #   }
        # ];
      };
    };
  };
}

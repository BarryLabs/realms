{ config
, lib
, ...
}:
with lib; let
  module = "wireguard";
  cfg = config.augs.vpn.${module};
in
{
  options.augs.vpn.${module}.enable = mkEnableOption "Wireguard Module";
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

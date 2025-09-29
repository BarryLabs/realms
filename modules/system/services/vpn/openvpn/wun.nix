{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.vpn.openvpn.wun;
in
{
  options.augs.vpn.openvpn.wun.enable = mkEnableOption "Wun OpenVPN Module";
  config = mkIf cfg.enable {
    services = {
      openvpn = {
        servers = {
          wun = {
            autoStart = false;
            config = ''
              config /root/.config/openvpn/wun.conf
            '';
          };
        };
      };
    };
  };
}

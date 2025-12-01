{ config
, lib
, ...
}:
with lib; let
  module = "openvpn";
  cfg = config.augs.vpn.${module};
in
{
  options.augs.vpn.${module}.enable = mkEnableOption "OpenVPN Module";
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

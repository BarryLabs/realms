{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.traefik;
in
{
  options.augs.services.traefik.enable = mkEnableOption "Base Traefik Module";
  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    systemd.services.traefik.serviceConfig = {
      EnvironmentFile = [ "/run/secrets/something" ];
    };
    services.traefik = {
      enable = true;
      staticConfigOptions = {
        log.level = "WARN";
        api = { };
        certificateResolvers = {
          cloudflare = {
            acme = {
              email = "host.clang101@aleeas.com";
              storage = "/var/lib/traefik/acme.json";
              caserver = "https://acme-v02.api.letsencrypt.org/directory";
              dnsChallenge = {
                provider = "cloudflare";
                resolvers = [ "1.1.1.1:53" "8.8.8.8:53" ];
                propagation.delayBeforeChecks = 120;
              };
            };
          };
        };
        entryPoints = {
          web = {
            address = ":80";
            http.redirections.entryPoint = {
              to = "websecure";
              scheme = "https";
            };
          };
          websecure.address = ":443";
        };
      };
      dynamicConfigOptions = {
        routers = {
          middlewares = {
            auth = {
              basicAuth = {
                users = [ "surtr:PASSWORD" ];
              };
            };
          };
          api = {
            rule = "Host(`muspelheim`)";
            service = "api@internal";
            entrypoints = [ "websecure" ];
            middlewares = [ "auth" ];
            tls = {
              certResolver = "cloudflare";
            };
          };
          mailserver = {
            rule = "Host(`m`)";
          };
        };
      };
    };
  };
}

{ config
, lib
, ...
}:
with lib; let
  cfg = config.augs.services.homepage;
in
{
  options.augs.services.homepage.enable = mkEnableOption "Homepage Module for Realms";
  config = mkIf cfg.enable {
    services = {
      homepage-dashboard =
        let
          port = 8082;
          webTitle = "Realms Homepage";
        in
        {
          enable = true;
          openFirewall = true;
          listenPort = port;
          customCSS = "";
          customJS = "";
          settings = {
            title = webTitle;
            theme = "dark";
            language = "en";
            color = "emerald";
            target = "_blank";
            hideVersion = "true";
            headerStyle = "boxed";
            favicon = "../../../../.config/homepage/favicon.ico";
            background = {
              image = "https://unsplash.com/photos/7BjhtdogU3A/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8MTB8fGRhcmslMjBwaXJhdGUlMjBzaGlwfGVufDB8fHx8MTc0MzQ1MzgyNnww&force=true";
              saturate = 25;
              opacity = 80;
            };
            layout = {
              NAS = {
                tab = "Family";
                useEqualHeights = true;
                initiallyCollapsed = false;
                style = "row";
                columns = 2;
              };
              HomeTheater = {
                tab = "Family";
                useEqualHeights = true;
                initiallyCollapsed = false;
                style = "row";
                columns = 2;
              };
              Monitoring = {
                tab = "Full";
                useEqualHeights = true;
                initiallyCollapsed = false;
                style = "row";
                columns = 1;
              };
              Infrastructure = {
                tab = "Full";
                useEqualHeights = true;
                initiallyCollapsed = false;
                style = "row";
              };
              Media = {
                tab = "Full";
                useEqualHeights = true;
                initiallyCollapsed = false;
                style = "row";
                columns = 4;
              };
              Storage = {
                tab = "Full";
                useEqualHeights = true;
                initiallyCollapsed = false;
                style = "row";
                columns = 3;
              };
            };
          };
          widgets = [
            {
              logo = {
                icon = "";
              };
            }
            {
              resources = {
                cpu = true;
                disk = "/";
                memory = true;
              };
            }
            {
              search = {
                provider = "google";
                target = "_blank";
                showSearchSuggestions = true;
              };
            }
            {
              datetime = {
                text_size = "md";
                format = {
                  timeStyle = "long";
                  hour12 = true;
                };
              };
            }
          ];
          services = [
            {
              "Infrastructure" = [
                {
                  "Router" = {
                    icon = "opnsense.png";
                    href = "http://192.168.1.1/";
                  };
                }
                {
                  "Sagittarius" = {
                    icon = "proxmox.png";
                    href = "http://192.168.1.5:8006/";
                  };
                }
                {
                  "Wolf" = {
                    icon = "proxmox.png";
                    href = "http://192.168.1.15:8006/";
                  };
                }
                {
                  "Milky" = {
                    icon = "proxmox.png";
                    href = "http://192.168.1.10:8006/";
                  };
                }
                {
                  "Dipper" = {
                    icon = "proxmox.png";
                    href = "http://192.168.1.20:8006/";
                  };
                }
              ];
            }
            {
              "Monitoring" = [
                {
                  "Homepage" = {
                    icon = "homepage.png";
                    href = "http://192.168.70.5:8082/";
                  };
                }
                {
                  "Gotify" = {
                    icon = "gotify.png";
                    href = "http://192.168.70.5/";
                  };
                }
                {
                  "Grafana" = {
                    icon = "grafana.png";
                    href = "http://192.168.70.5:3000/";
                  };
                }
                {
                  "Prometheus" = {
                    icon = "prometheus.png";
                    href = "http://192.168.70.5:9090/";
                  };
                }
                {
                  "Loki" = {
                    icon = "loki.png";
                    href = "http://192.168.70.5:3100/";
                  };
                }
              ];
            }
            {
              "Media" = [
                {
                  "Jellyseerr" = {
                    icon = "jellyseerr.png";
                    href = "http://192.168.30.5:5055/";
                  };
                }
                {
                  "Jellyfin" = {
                    icon = "jellyfin.png";
                    href = "http://192.168.30.5:8096/";
                  };
                }
                {
                  "qBittorrent" = {
                    icon = "qbittorrent.png";
                    href = "http://192.168.30.5:8080/";
                  };
                }
                {
                  "Tdarr" = {
                    icon = "tdarr.png";
                    href = "http://192.168.30.5:8265/";
                  };
                }
                {
                  "Prowlarr" = {
                    icon = "prowlarr.png";
                    href = "http://192.168.30.5:9696/";
                  };
                }
                {
                  "Radarr" = {
                    icon = "radarr.png";
                    href = "http://192.168.30.5:7878/";
                  };
                }
                {
                  "Sonarr" = {
                    icon = "sonarr.png";
                    href = "http://192.168.30.5:8989/";
                  };
                }
              ];
            }
            {
              "Storage" = [
                {
                  "pgAdmin" = {
                    icon = "pgadmin.png";
                    href = "http://192.168.40.5:5050/";
                  };
                }
                {
                  "Syncthing" = {
                    icon = "syncthing.png";
                    href = "http://192.168.40.5:8384/";
                  };
                }
                {
                  "Nextcloud" = {
                    icon = "nextcloud.png";
                    href = "http://192.168.40.5/";
                  };
                }
                {
                  "Gitea" = {
                    icon = "gitea.png";
                    href = "http://192.168.40.5:3000/";
                  };
                }
                {
                  "Paperless" = {
                    icon = "paperless-ngx.png";
                    href = "http://192.168.40.5:8000/";
                  };
                }
                {
                  "Immich" = {
                    icon = "immich.png";
                    href = "http://192.168.40.5:2283/";
                  };
                }
              ];
            }
            {
              "HomeTheater" = [
                {
                  "Jellyseerr" = {
                    icon = "jellyseerr.png";
                    href = "http://192.168.30.5:5055/";
                  };
                }
                {
                  "Jellyfin" = {
                    icon = "jellyfin.png";
                    href = "http://192.168.30.5:8096/";
                  };
                }
              ];
            }
            {
              "NAS" = [
                {
                  "Nextcloud" = {
                    icon = "nextcloud.png";
                    href = "http://192.168.40.5/";
                  };
                }
                {
                  "Gitea" = {
                    icon = "gitea.png";
                    href = "http://192.168.40.5:3000/";
                  };
                }
                {
                  "Paperless" = {
                    icon = "paperless-ngx.png";
                    href = "http://192.168.40.5:8000/";
                  };
                }
                {
                  "Immich" = {
                    icon = "immich.png";
                    href = "http://192.168.40.5:2283/";
                  };
                }
              ];
            }
          ];
        };
    };
  };
}

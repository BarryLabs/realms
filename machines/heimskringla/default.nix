{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
    ../../modules/profile/system
  ];

  augs = {
    profile = {
      server.enable = true;
    };
    svc = {
      promtail.enable = true;
      node-exporter.enable = true;
      grafana.enable = true;
      homepage.enable = true;
      loki.enable = true;
      prometheus.enable = true;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 3000 3100 9001 ];
    };
  };
}

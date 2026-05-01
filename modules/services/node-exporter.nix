{
  flake.nixosModules.node-exporter = {
    services = {
      prometheus = {
        exporters = {
          node = {
            enable = true;
            port = 9002;
            openFirewall = true;
            enabledCollectors = ["systemd"];
          };
        };
      };
    };
  };
}

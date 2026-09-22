{
  flake.nixosModules.node-exporter = {
    services = {
      prometheus = {
        exporters = {
          node = {
            enable = true;
            port = 9100;
            openFirewall = true;
            enabledCollectors = [
              "cpu"
              "meminfo"
              "diskstats"
              "filesystem"
              "loadavg"
              "netdev"
              "stat"
              "time"
              "timex"
              "vmstat"
              "systemd"
            ];
            disabledCollectors = [
              "rapl"
            ];
          };
        };
      };
    };
  };
}

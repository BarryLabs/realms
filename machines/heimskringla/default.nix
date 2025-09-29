{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    com = {
      bash.enable = true;
      bootEFI.enable = false;
      bootGRUB.enable = true;
      cpu.enable = false;
      docs.enable = true;
      environment.enable = true;
      kernel.enable = true;
      locale.enable = true;
      network.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      openssh.enable = true;
      qemuguest.enable = true;
      sops.enable = false;
      state.enable = true;
      timezone.enable = true;
      users.enable = true;
      vmVariant = false;
      zram.enable = false;
      zfs.enable = false;
    };
    services = {
      promtail.enable = true;
      node-exporter.enable = true;
      gotify.enable = true;
      grafana.enable = true;
      homepage.enable = true;
      loki.enable = true;
      prometheus.enable = true;
    };
  };

  sops = {
    secrets = { };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ 3000 3100 8080 9001 ];
    };
  };
}

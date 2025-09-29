{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];
  augs = {
    com = {
      bash.enable = true;
      environment.enable = true;
      locale.enable = true;
      network.enable = true;
      nix.enable = true;
      nixpkgs.enable = true;
      openssh.enable = true;
      qemuguest.enable = true;
      settings.enable = true;
      sops.enable = false;
      state.enable = true;
      timezone.enable = true;
      users.enable = true;
    };
    services = {
      node-exporter.enable = false;
      promtail.enable = false;
      traefik.enable = true;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [ ];
    };
  };

  # sops = {
  #   secrets = {};
  # };
}

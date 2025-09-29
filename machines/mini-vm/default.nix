{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];

  augs = {
    com = {
      bash.enable = true;
      bootGRUB.enable = false;
      docs.enable = true;
      environment.enable = true;
      governor.enable = false;
      kernel.enable = false;
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
      vmVariant.enable = true;
    };
    services = {
      node-exporter.enable = false;
      promtail.enable = false;
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

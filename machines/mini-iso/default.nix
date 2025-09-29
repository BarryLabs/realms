{
  imports = [
    ./variables.nix
    ../../modules/system
  ];
  augs = {
    com = {
      bash.enable = true;
      bootEFI.enable = false;
      bootGRUB.enable = true;
      cpu.enable = true;
      docs.enable = true;
      environment.enable = true;
      governor.enable = true;
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
      vmVariant.enable = true;
    };
    services = {
      node-exporter.enable = false;
      promtail.enable = false;
    };
  };

  networking = {
    firewall = {
      allowedTCPPorts = [];
    };
  };

  # sops = {
  #   secrets = {};
  # };
}

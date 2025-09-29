{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];
  augs = {
    com = {
      bash.enable = true;
      bootGRUB.enable = true;
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
    };
    services = {
      node-exporter.enable = false;
      promtail.enable = false;
      home-assistant.enable = true;
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

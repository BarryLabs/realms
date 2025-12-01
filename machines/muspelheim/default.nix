{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../modules/system
  ];
  augs = {
    profile = {
      server.enable = true;
      monitoring.enable = true;
    };
    svc = {
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

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
      # minecraft.enable = true;
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

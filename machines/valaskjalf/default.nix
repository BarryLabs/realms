{
  imports = [
    ./disko.nix
    ./variables.nix
    ../../profiles/system
    ../../modules/system
  ];
  augs = {
    com = {
      bootGRUB.enable = true;
      sops.enable = true;
    };
    profile = {
      server.enable = true;
    };
    svc = {
      email.enable = true;
    };
  };
  networking = {
    firewall = {
      allowedTCPPorts = [ ];
    };
  };
  sops = {
    secrets = {
      "postmasters_key" = {
        mode = "0400";
      };
    };
  };
}

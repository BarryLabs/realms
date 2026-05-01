{config, ...}: {
  flake.nixosModules.network = {
    networking = {
      firewall = {
        enable = true;
        allowedUDPPorts = [];
        allowedTCPPorts = [];
      };
    };
  };
}

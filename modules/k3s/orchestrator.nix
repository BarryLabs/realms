{
  flake.nixosModules.orchestrator = {
    networking.firewall = {
      allowedTCPPorts = [6443];
      allowedUDPPorts = [8472];
    };
    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        "--debug"
      ];
    };
  };
}

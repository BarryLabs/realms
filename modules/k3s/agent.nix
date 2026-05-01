{
  flake.nixosModules.k3s-agent = {
    services.k3s = {
      enable = true;
      role = "agent";
      token = "";
      serverAddr = "https://<orchestrator>:6443";
    };
  };
}

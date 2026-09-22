{self, inputs, ...}: {
  imports = [
    ### Sops
    inputs.sops-nix.homeManagerModules.sops

    ### Quadlets
    ../../modules/quadlets/_grafana.nix
  ];

  home = {
    username = "heimdall";
    homeDirectory = "/home/heimdall";
    stateVersion = "26.05";
  };

  programs = {
    home-manager.enable = true;
    bash.enable = true;
  };

  sops = {
    age.keyFile = "/home/heimdall/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets/grafana.env;
  };
}

{self, pkgs, ...}: {
  imports = [
    # self.homeModules.grafana
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

  home.packages = with pkgs; [
    git
    htop
  ];
}

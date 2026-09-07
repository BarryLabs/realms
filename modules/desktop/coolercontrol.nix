{self, ...}: {
  flake.nixosModules.coolercontrol = {pkgs, ...}: {
    programs.coolercontrol.enable = true;
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.coolercontrol];

    # persistence.data.directories = [
    #   ".config/org.coolercontrol.CoolerControl"
    #   ".local/share/org.coolercontrol.CoolerControl"
    # ];
  };

  flake.homeModules.coolercontrol = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.coolercontrol];
  };

  perSystem = {pkgs, ...}: {
    packages.coolercontrol = pkgs.coolercontrol.coolercontrol-gui;
  };
}

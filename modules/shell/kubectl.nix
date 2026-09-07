{self, ...}: {
  flake.nixosModules.kubectl = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.kubectl
      self.packages.${pkgs.stdenv.hostPlatform.system}.helm
    ];
  };

  flake.homeModules.kubectl = {pkgs, ...}: {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.kubectl
      self.packages.${pkgs.stdenv.hostPlatform.system}.helm
    ];
  };

  perSystem = {pkgs, ...}: {
    packages.kubectl = pkgs.kubectl;

    packages.helm = pkgs.wrapHelm pkgs.kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    };
  };
}

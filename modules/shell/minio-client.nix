{self, ...}: {
  flake.nixosModules.minio-client = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.minio-client];
  };

  flake.homeModules.minio-client = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.minio-client];
  };

  perSystem = {pkgs, ...}: {
    packages.minio-client = pkgs.minio-client;
  };
}

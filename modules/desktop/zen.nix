{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.zen = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.zen];
    # persistence.data.directories = [
    #   ".zen"
    # ];
  };

  flake.homeModules.zen = {pkgs, ...}: {
    home.packages = [self.packages.${pkgs.stdenv.hostPlatform.system}.zen];
  };

  perSystem = {system, ...}: {
    packages.zen = inputs.zen-browser.packages.${system}.default;
  };
}

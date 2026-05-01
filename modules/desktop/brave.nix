{
  flake.nixosModules.brave = {pkgs, ...}: {
    environment.systemPackages = [pkgs.brave];
  };
  flake.homeModules.brave = {pkgs, ...}: {
    home.packages = [pkgs.brave];
  };
}

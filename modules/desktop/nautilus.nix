{
  flake.nixosModules.nautilus = {pkgs, ...}: {
    environment.systemPackages = [pkgs.nautilus];
  };
}

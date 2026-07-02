{
  flake.nixosModules.kdeconnect = {pkgs, ...}: {
    environment.systemPackages = [pkgs.kdePackages.kdeconnect-kde];
  };
}

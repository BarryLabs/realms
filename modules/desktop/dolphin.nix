{
  flake.nixosModules.dolphin = {pkgs, ...}: {
    environment.systemPackages = [pkgs.kdePackages.dolphin pkgs.kdePackages.dolphin-plugins];
  };
}

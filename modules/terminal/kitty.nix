{
  flake.nixosModules.kitty = {pkgs, ...}: {
    environment.systemPackages = [pkgs.kitty];
  };
  flake.homeModules.kitty = {pkgs, ...}: {
    home.packages = [
      pkgs.kitty
    ];
  };
}

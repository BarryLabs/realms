{
  flake.nixosModules.helix = {pkgs, ...}: {
    environment.systemPackages = [pkgs.helix];
  };
  flake.homeModules.helix = {pkgs, ...}: {
    home.packages = with pkgs; [
      helix
    ];
  };
}

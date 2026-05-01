{
  flake.nixosModules.yazi = {pkgs, ...}: {
    environment.systemPackages = [pkgs.yazi];
  };
  flake.homeModules.yazi = {pkgs, ...}: {
    home.packages = with pkgs; [
      yazi
    ];
  };
}

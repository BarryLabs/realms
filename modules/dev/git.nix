{
  flake.nixosModules.git = {pkgs, ...}: {
    environment.systemPackages = [pkgs.git];
  };
  flake.homeModules.git = {pkgs, ...}: {
    home.packages = with pkgs; [
      git
    ];
  };
}

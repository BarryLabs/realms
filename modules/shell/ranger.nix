{
  flake.nixosModules.ranger = {pkgs, ...}: {
    environment.systemPackages = [pkgs.ranger];
  };
  flake.homeModules.ranger = {pkgs, ...}: {
    home.packages = with pkgs; [
      ranger
    ];
  };
}

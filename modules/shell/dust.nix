{
  flake.nixosModules.dust = {pkgs, ...}: {
    environment.systemPackages = [pkgs.dust];
  };
  flake.homeModules.dust = {pkgs, ...}: {
    home.packages = with pkgs; [
      dust
    ];
  };
}

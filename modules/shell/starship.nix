{
  flake.nixosModules.starship = {pkgs, ...}: {
    environment.systemPackages = [pkgs.starship];
  };
  flake.homeModules.starship = {pkgs, ...}: {
    home.packages = with pkgs; [
      starship
    ];
  };
}

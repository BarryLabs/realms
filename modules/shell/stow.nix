{
  flake.nixosModules.stow = {pkgs, ...}: {
    environment.systemPackages = [pkgs.stow];
  };
  flake.homeModules.stow = {pkgs, ...}: {
    home.packages = with pkgs; [
      stow
    ];
  };
}

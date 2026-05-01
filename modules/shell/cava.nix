{
  flake.nixosModules.cava = {pkgs, ...}: {
    environment.systemPackages = [pkgs.cava];
  };
  flake.homeModules.cava = {pkgs, ...}: {
    home.packages = with pkgs; [
      cava
    ];
  };
}

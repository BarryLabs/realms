{
  flake.nixosModules.fastfetch = {pkgs, ...}: {
    environment.systemPackages = [pkgs.fastfetch];
  };
  flake.homeModules.fastfetch = {pkgs, ...}: {
    home.packages = with pkgs; [
      fastfetch
    ];
  };
}

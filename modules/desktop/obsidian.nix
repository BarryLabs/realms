{
  flake.nixosModules.obsidian = {pkgs, ...}: {
    environment.systemPackages = [pkgs.obsidian];
  };
  flake.homeModules.obsidian = {pkgs, ...}: {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}

{
  flake.nixosModules.pandoc = {pkgs, ...}: {
    environment.systemPackages = [pkgs.pandoc];
  };
  flake.homeModules.pandoc = {pkgs, ...}: {
    home.packages = with pkgs; [
      pandoc
    ];
  };
}

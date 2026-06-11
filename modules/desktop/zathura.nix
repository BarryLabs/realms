{
  flake.nixosModules.zathura = {pkgs, ...}: {
    environment.systemPackages = [pkgs.zathura-with-plugins];
  };
  flake.homeModules.zathura = {pkgs, ...}: {
    home.packages = with pkgs; [
      zathura-with-plugins
    ];
  };
}

{
  flake.nixosModules.zathura = {pkgs, ...}: {
    environment.systemPackages = [pkgs.zathura];
  };
  flake.homeModules.zathura = {pkgs, ...}: {
    home.packages = with pkgs; [
      zathura
    ];
  };
}

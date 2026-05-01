{
  flake.nixosModules.bat = {pkgs, ...}: {
    environment.systemPackages = [pkgs.bat];
  };
  flake.homeModules.bat = {pkgs, ...}: {
    home.packages = with pkgs; [
      bat
    ];
  };
}

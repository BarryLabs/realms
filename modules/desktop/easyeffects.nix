{
  flake.nixosModules.easyeffects = {pkgs, ...}: {
    environment.systemPackages = [pkgs.easyeffects];
  };
  flake.homeModules.easyeffects = {pkgs, ...}: {
    home.packages = with pkgs; [
      easyeffects
    ];
  };
}

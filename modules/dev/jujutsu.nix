{
  flake.nixosModules.jujutsu = {pkgs, ...}: {
    environment.systemPackages = [pkgs.jujutsu];
  };
  flake.homeModules.jujutsu = {pkgs, ...}: {
    home.packages = with pkgs; [
      jujutsu
    ];
  };
}

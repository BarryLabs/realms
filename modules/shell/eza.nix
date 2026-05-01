{
  flake.nixosModules.eza = {pkgs, ...}: {
    environment.systemPackages = [pkgs.eza];
  };
  flake.homeModules.eza = {pkgs, ...}: {
    home.packages = with pkgs; [
      eza
    ];
  };
}

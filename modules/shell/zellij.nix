{
  flake.nixosModules.zellij = {pkgs, ...}: {
    environment.systemPackages = [pkgs.zellij];
  };
  flake.homeModules.zellij = {pkgs, ...}: {
    home.packages = with pkgs; [
      zellij
    ];
  };
}

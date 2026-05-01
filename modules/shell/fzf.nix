{
  flake.nixosModules.fzf = {pkgs, ...}: {
    environment.systemPackages = [pkgs.fzf];
  };
  flake.homeModules.fzf = {pkgs, ...}: {
    home.packages = with pkgs; [
      fzf
    ];
  };
}

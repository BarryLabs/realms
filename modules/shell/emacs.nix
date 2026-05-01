{
  flake.nixosModules.emacs = {pkgs, ...}: {
    environment.systemPackages = [pkgs.emacs];
  };
  flake.homeModules.emacs = {pkgs, ...}: {
    home.packages = with pkgs; [
      emacs
    ];
  };
}

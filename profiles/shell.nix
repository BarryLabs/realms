{self, ...}: {
  flake.nixosModules.shell = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      direnv
      devenv
      helix
      fastfetch
      stow
      yazi
      zellij
    ];
  };
}

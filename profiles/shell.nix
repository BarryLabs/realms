{self, ...}: {
  flake.nixosModules.shell = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      devenv
      helix
      fastfetch
      stow
      yazi
      zellij

      podman
      podman-compose
    ];
  };
}

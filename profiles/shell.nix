{self, ...}: {
  flake.nixosModules.shell = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      foot
      helix
      ghostty
      eza
      dust
      fastfetch
      minio-client
      starship
      stow
      yazi
      zellij
      zoxide

      podman
      podman-compose
    ];
  };
}

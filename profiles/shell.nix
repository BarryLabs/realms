{self, ...}: {
  flake.nixosModules.shell = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
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
      zsh

      podman
      podman-compose
    ];
  };
}

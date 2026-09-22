{self, ...}: {
  flake.nixosModules.base = {pkgs, ...}: {
    imports = [
      self.nixosModules.locale
      self.nixosModules.network
      self.nixosModules.nh
      self.nixosModules.nix
      self.nixosModules.openssh
      self.nixosModules.security
      self.nixosModules.settings
      self.nixosModules.sudo-rs
      self.nixosModules.timezone

      self.nixosModules.node-exporter
    ];

    environment.systemPackages = with pkgs; [
      git
      htop
    ];

    programs.bash.completion.enable = true;
  };
}

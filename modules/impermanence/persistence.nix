{self, ...}: {
  flake.nixosModules.persistence = {config, ...}: {
    imports = [
      self.nixosModules.impermanence
    ];

    persistence.enable = true;
    persistence.user = config.preferences.user.name;
  };
}

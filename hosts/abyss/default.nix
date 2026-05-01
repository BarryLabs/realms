{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.abyss = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.abyssConfiguration
    ];
  };
}

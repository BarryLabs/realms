{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.asgard = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.asgardConfiguration
    ];
  };
}

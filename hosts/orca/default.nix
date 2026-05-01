{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.orca = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.orcaConfiguration
    ];
  };
}

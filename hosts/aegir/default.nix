{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.aegir = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.aegirConfiguration
    ];
  };
}

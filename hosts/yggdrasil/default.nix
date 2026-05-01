{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.yggdrasil = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.yggdrasilConfiguration
    ];
  };
}

{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.bifrost = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager

      self.nixosModules.bifrostHardware
      self.nixosModules.bifrostConfiguration
      self.nixosModules.bifrostUsers

      self.nixosModules.sops
    ];
  };

  flake.homeConfigurations."heimdall@bifrost" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    modules = [
      ./home.nix
    ];
  };
}

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

      {
        home-manager = {
          backupFileExtension = "bak";
          extraSpecialArgs = { inherit inputs self; };
          useGlobalPkgs = true;
          useUserPackages = true;
          users.heimdall = import ./_home.nix;
        };
      }
    ];
  };

  flake.homeConfigurations."heimdall@bifrost" = let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs.extend (final: prev: {
        buildGo125Module = final.buildGoModule;
      });
      extraSpecialArgs = { inherit inputs self; };
      modules = [
        ./_home.nix
      ];
    };
}

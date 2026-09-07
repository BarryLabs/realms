{
  self,
  inputs,
  ...
}: {
  flake.nixOnDroidConfigurations.jotunheim = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    pkgs = import inputs.nixpkgs {
      system = "aarch64-linux";
      overlays = [
        inputs.nix-on-droid.overlays.default
      ];
      config = {
        allowUnfree = true;
      };
    };

    modules = [
      self.nixOnDroidModules.jotunheimConfiguration
    ];
  };
}

{
  inputs,
  config,
  ...
}: {
  flake.nixosModules.sops = {lib, ...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    # sops-nix currently references buildGo125Module, which has been
    # removed from nixpkgs now that Go 1.25 is end-of-life.  Re-introduce
    # it as an alias to the current default Go builder until upstream is
    # updated.
    nixpkgs.overlays = [
      (final: prev: {
        buildGo125Module = final.buildGoModule;
      })
    ];

    sops = {
      age = {
        keyFile = config.var.ageFile;
      };
      defaultSopsFormat = lib.mkDefault "yaml";
      defaultSopsFile = lib.mkDefault ../../secrets/${config.var.host}.yaml;
    };
  };
}

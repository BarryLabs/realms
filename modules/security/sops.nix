{
  inputs,
  config,
  ...
}: {
  flake.nixosModules.sops = {lib, ...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
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

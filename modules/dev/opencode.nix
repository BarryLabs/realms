{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.opencode = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myOpencode];
  };
  perSystem = {pkgs, ...}: {
    packages.myOpencode = inputs.wrapper-modules.wrappers.opencode.wrap {
      inherit pkgs;
      settings = {
        permission = {
          "*" = "ask";
        };
      };
    };
  };
}

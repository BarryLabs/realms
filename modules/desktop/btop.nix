{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.btop = {pkgs, ...}: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myBtop
    ];
  };
  perSystem = {pkgs, ...}: {
    packages.myBtop = inputs.wrapper-modules.wrappers.btop.wrap {
      inherit pkgs;
      settings = {
        vim_keys = true;
      };
    };
  };
}

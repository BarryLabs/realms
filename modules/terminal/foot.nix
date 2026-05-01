{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.foot = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myFoot];
  };
  perSystem = {pkgs, ...}: {
    packages.myFoot = inputs.wrapper-modules.wrappers.foot.wrap {
      inherit pkgs;
      settings = {
        main = {
          font = "SourceCodePro:size=11";
          font-bold = "SourceCodePro:size=11";
          font-italic = "SourceCodePro:size=11";
          font-bold-italic = "SourceCodePro:size=11";
          dpi-aware = "yes";
          pad = "12x12";
        };
      };
    };
  };
}

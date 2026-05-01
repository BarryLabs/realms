{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia];
  };
  perSystem = {pkgs, ...}: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = {
        bar = {
          position = "top";
          barType = "simple";
          density = "compact";
          displayMode = "auto_hide";
          floating = true;
          backgroundOpacity = 0.95;
        };
        colorSchemes = {
          darkMode = true;
          useWallpaperColors = true;
        };
        general = {
          animationSpeed = 0.8;
          radiusRatio = 1.2;
          clockFormat = "h:mm AP";
        };
        location = {
          autoLocate = true;
          useFahrenheit = true;
        };
        nightlight = {
          forced = true;
          nightTemp = "4000";
        };
      };
    };
  };
}

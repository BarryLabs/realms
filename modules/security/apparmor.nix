{
  flake.nixosModules.apparmor = {pkgs, ...}: {
    security = {
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
        packages = with pkgs; [
          apparmor-utils
          apparmor-profiles
        ];
      };
    };
  };
}

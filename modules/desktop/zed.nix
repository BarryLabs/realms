{
  flake.nixosModules.zed = {pkgs, ...}: {
    environment.systemPackages = [pkgs.zed-editor];
  };
  flake.homeModules.zed = {
    programs = {
      zed-editor = {
        enable = true;
      };
    };
  };
}

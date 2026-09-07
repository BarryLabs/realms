{self, ...}: {
  flake.nixosModules.zed = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.zed];
    # persistence.data.directories = [
    #   ".config/zed"
    #   ".local/share/zed"
    # ];
  };

  flake.homeModules.zed = {pkgs, ...}: {
    programs.zed-editor = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.zed;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.zed = pkgs.zed-editor;
  };
}

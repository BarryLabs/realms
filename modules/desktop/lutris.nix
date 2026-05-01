{
  flake.nixosModules.lutris = {pkgs, ...}: {
    environment.systemPackages = [pkgs.lutris];
  };
  flake.homeModules.lutris = {pkgs, ...}: {
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    };
    home.packages = with pkgs; [
      (lutris.override {
        extraPkgs = pkgs: [
          adwaita-icon-theme
        ];
      })
    ];
  };
}

{ self, ... }: {
  flake.nixosModules.mangohud = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.mangohud ];

    # persistence.data.directores = [
    #   ".config/MangoHud"
    # ];
  };

  flake.homeModules.mangohud = { pkgs, ... }: {
    programs.mangohud = {
      enable = true;
      enableSessionWide = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.mangohud;
      settingsPerApplication = {
        mpv.no_display = true;
        zen.no_display = true;
        nautilus.no_display = true;
        xdg-desktop-portal-gnome.no_display = true;
      };
    };
  };

  perSystem = { pkgs, ... }: {
    packages.mangohud = pkgs.mangohud;
  };
}

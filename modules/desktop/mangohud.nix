{
  flake.nixosModules.mangohud = {pkgs, ...}: {
    environment.systemPackages = [pkgs.mangohud];
  };
  flake.homeModules.mangohud = {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = true;
        settingsPerApplication = {
          mpv = {
            no_display = true;
          };
          zen = {
            no_display = true;
          };
          nautilus = {
            no_display = true;
          };
          xdg-desktop-portal-gnome = {
            no_display = true;
          };
        };
      };
    };
  };
}

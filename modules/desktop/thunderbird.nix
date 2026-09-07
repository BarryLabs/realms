{self, ...}: {
  flake.nixosModules.thunderbird = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.thunderbird];
    # persistence.data.directories = [
    #   ".thunderbird"
    # ];
  };

  flake.homeModules.thunderbird = {pkgs, ...}: {
    programs.thunderbird = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.thunderbird;
      settings = {
        "privacy.donottrackheader.enabled" = true;
        "extensions.autoDisableScopes" = 0;
      };
      profiles = {
        default = {
          isDefault = true;
          withExternalGnupg = false;
          settings = {
            "mail.spellcheck.inline" = false;
            "mailnews.database.global.views.global.columns" = {
              selectCol = {
                visible = false;
                ordinal = 1;
              };
              threadCol = {
                visible = true;
                ordinal = 2;
              };
            };
          };
        };
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.thunderbird = pkgs.thunderbird;
  };
}

{ self, ... }: {
  flake.nixosModules.steam = { pkgs, ... }:
    let
      sys = pkgs.stdenv.hostPlatform.system;
    in
    {
      environment.systemPackages = with self.packages.${sys}; [
        gamescope-wsi
        protonup-qt
        adwsteamgtk
      ];

      programs = {
        gamemode.enable = true;
        gamescope = {
          enable = true;
          capSysNice = false;
          # package = inputs.chaotic.gamescope_git;
        };
        steam = {
          enable = true;
          dedicatedServer.openFirewall = true;
          gamescopeSession.enable = true;
          remotePlay.openFirewall = false;
        };
      };
      # persistence.data.directories = [
      #   ".local/share/Steam"
      #   ".config/gamescope"
      #   ".local/share/gamescope"
      # ];
    };

  perSystem = { pkgs, ... }: {
    packages.gamescope-wsi = pkgs.gamescope-wsi;
    packages.protonup-qt = pkgs.protonup-qt;
    packages.adwsteamgtk = pkgs.adwsteamgtk;
  };
}

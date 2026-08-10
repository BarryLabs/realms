{
  flake.nixosModules.steam = {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      gamescope-wsi
      protonup-qt
      adwsteamgtk
    ];
    programs = {
      gamemode = {
        enable = true;
      };
      gamescope = {
        enable = true;
        capSysNice = false;
        # package = inputs.chaotic.gamescope_git;
      };
      steam = {
        enable = true;
        dedicatedServer = {
          openFirewall = true;
        };
        gamescopeSession = {
          enable = true;
        };
        remotePlay = {
          openFirewall = false;
        };
      };
    };
  };
}

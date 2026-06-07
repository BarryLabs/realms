{
  flake.nixosModules.steam = {
    pkgs,
    lib,
    inputs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      gamescope-wsi
      protonup-qt
      adwsteamgtk
    ];
    nixpkgs = {
      config = {
        allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "steam"
            "steam-unwrapped"
          ];
      };
    };
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

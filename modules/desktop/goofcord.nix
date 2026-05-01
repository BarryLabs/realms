{
  flake.nixosModules.goofcord = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      goofcord
    ];

    # persistance.data.directories = lib.mkIf config.persistance.enable [
    #   ".config/goofcord"
    # ];
  };

  flake.homeModules.goofcord = {pkgs, ...}: {
    home.packages = with pkgs; [
      goofcord
    ];
  };
}

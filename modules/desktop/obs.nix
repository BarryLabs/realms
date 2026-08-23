{ self, ... }: {
  flake.nixosModules.obs = { pkgs, ... }: {
    environment.systemPackages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.obs ];

    # persistence.data.directories = [
    #   ".config/obs-studio"
    # ];
  };

  flake.homeModules.obs = { pkgs, ... }: {
    programs.obs-studio = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.obs;
      plugins = with pkgs.obs-studio-plugins; [
        input-overlay
        obs-vkcapture
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
  };

  perSystem = { pkgs, ... }: {
    packages.obs = pkgs.obs-studio;
  };
}

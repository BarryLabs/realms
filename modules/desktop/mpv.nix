{self, ...}: {
  flake.nixosModules.mpv = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.mpv];

    # persistence.data.directores = [
    #   ".config/mpv"
    # ];
  };

  flake.homeModules.mpv = {pkgs, ...}: {
    programs.mpv = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.mpv;
      bindings = {
        "c" = "script-message-to crop start-crop hard";
        "d" = "vf del -1";
        "Alt+c" = "script-message-to crop start-crop soft";
        "l" = "script-message-to crop start-crop delogo";
        "w" = "script-binding modernz/progress-toggle";
        "x" = "script-message-to modernz osc-show";
        "y" = "script-message-to modernz osc-visibility cycle";
        "z" = "script-message-to modernz osc-idlescreen";
      };
      config = {
        profile = "gpu-hq";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.mpv = pkgs.mpv;
  };
}

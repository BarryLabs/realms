{self, ...}: {
  flake.nixosModules.chromium = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.chromium];
    # persistence = {
    #   data.directories = [
    #     ".config/chromium"
    #   ];
    #   cache.directories = [
    #     ".cache/chromium"
    #   ];
    # };
  };

  flake.homeModules.chromium = {pkgs, ...}: {
    programs.chromium = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.chromium;
      commandLineArgs = [
        "--enable-logging=stderr"
        "--ignore-gpu-blocklist"
      ];
      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";}
      ];
    };
  };

  perSystem = {pkgs, ...}: {
    packages.chromium = pkgs.ungoogled-chromium;
  };
}

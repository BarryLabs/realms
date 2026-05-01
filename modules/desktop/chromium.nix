{
  flake.nixosModules.chromium = {pkgs, ...}: {
    environment.systemPackages = [pkgs.ungoogled-chromium];
  };
  flake.homeModules.chromium = {
    programs = {
      chromium = {
        enable = true;
        commandLineArgs = [
          "--enable-logging=stderr"
          "--ignore-gpu-blocklist"
        ];
        extensions = [
          {
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          }
        ];
      };
    };
  };
}

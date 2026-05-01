{
  flake.nixosModules.clamav = {
    services.clamav = {
      daemon.enable = true;
      fangfrisch = {
        enable = true;
        interval = "daily";
      };
      updater = {
        enable = true;
        frequency = 12;
        interval = "daily";
      };
      scanner = {
        enable = true;
        interval = "Sat *-*-* 04:00:00";
      };
    };
  };
}

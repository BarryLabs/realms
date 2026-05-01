{config, ...}: {
  flake.nixosModules.timezone = {
    time = {
      hardwareClockInLocalTime = true;
      timeZone = "America/New_York";
    };
  };
}

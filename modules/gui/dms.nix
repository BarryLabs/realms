{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.dms = {
    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
  };
}

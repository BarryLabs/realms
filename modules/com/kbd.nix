{
  flake.nixosModules.kbd = {
    services = {
      xserver = {
        xkb = {
          layout = "us";
          variant = "";
        };
      };
    };
  };
}

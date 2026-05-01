{
  flake.nixosModules.weylus = {
    programs = {
      weylus = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

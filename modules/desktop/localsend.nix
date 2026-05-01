{
  flake.nixosModules.localsend = {
    programs = {
      localsend = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

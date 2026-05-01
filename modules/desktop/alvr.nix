{
  flake.nixosModules.alvr = {
    programs = {
      alvr = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}

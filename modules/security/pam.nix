{
  flake.nixosModules.pam = {
    security = {
      rtkit = {
        enable = true;
      };
      polkit = {
        enable = true;
      };
      pam = {
        services = {
          hyprlock = {};
        };
      };
    };
  };
}

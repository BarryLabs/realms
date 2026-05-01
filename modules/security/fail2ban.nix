{
  flake.nixosModules.fail2ban = {
    services.fail2ban = {
      enable = true;
    };
  };
}

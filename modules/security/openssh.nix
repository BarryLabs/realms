{config, ...}: {
  flake.nixosModules.openssh = {
    security.pam.services = {
      sshd.enableAppArmor = config.security.openssh.enable or false;
    };
    services.openssh = {
      enable = true;
      startWhenNeeded = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}

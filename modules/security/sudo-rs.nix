{
  flake.nixosModules.sudo-rs = {config, ...}: {
    security = {
      pam.services = {
        sudo-rs.enableAppArmor =
          if config.security.apparmor.enable
          then true
          else false;
      };
      sudo = {
        enable = false;
      };
      sudo-rs = {
        enable = true;
        execWheelOnly = true;
      };
    };
  };
}

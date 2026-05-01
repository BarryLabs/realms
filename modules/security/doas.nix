{config, ...}: {
  flake.nixosModules.doas = {
    security = {
      pam.services = {
        doas.enableAppArmor =
          if config.augs.com.apparmor.enable
          then true
          else false;
      };
      sudo = {
        enable = false;
      };
      doas = {
        enable = true;
        extraRules = [
          {
            groups = ["doas"];
            keepEnv = true;
            noPass = false;
          }
        ];
      };
    };
  };
}

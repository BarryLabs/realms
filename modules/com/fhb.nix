{config, ...}: {
  flake.nixosModules.fhb = {
    system = {
      activationScripts = {
        "fhsBuilder" = {
          text = ''
            install -d -m 755 /mnt/USB -o ${config.yggdrasil.user} -g users
            install -d -m 755 /home/${config.yggdrasil.user}/Documents -o ${config.yggdrasil.user} -g users
            install -d -m 755 /home/${config.yggdrasil.user}/Downloads -o ${config.yggdrasil.user} -g users
            install -d -m 755 /home/${config.yggdrasil.user}/Music -o ${config.yggdrasil.user} -g users
            install -d -m 755 /home/${config.yggdrasil.user}/Pictures -o ${config.yggdrasil.user} -g users
            install -d -m 755 /home/${config.yggdrasil.user}/Projects -o ${config.yggdrasil.user} -g users
            install -d -m 755 /home/${config.yggdrasil.user}/Videos -o ${config.yggdrasil.user} -g users
          '';
        };
      };
    };
  };
}

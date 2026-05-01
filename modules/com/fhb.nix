{config, ...}: {
  flake.nixosModules.fhb = {
    system = {
      activationScripts = {
        "fhsBuilder" = {
          text = ''
            install -d -m 755 /mnt/USB -o ${config.client.user} -g users
            install -d -m 755 /home/${config.client.user}/Documents -o ${config.client.user} -g users
            install -d -m 755 /home/${config.client.user}/Downloads -o ${config.client.user} -g users
            install -d -m 755 /home/${config.client.user}/Music -o ${config.client.user} -g users
            install -d -m 755 /home/${config.client.user}/Pictures -o ${config.client.user} -g users
            install -d -m 755 /home/${config.client.user}/Projects -o ${config.client.user} -g users
            install -d -m 755 /home/${config.client.user}/Videos -o ${config.client.user} -g users
          '';
        };
      };
    };
  };
}

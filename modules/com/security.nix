{config, ...}: {
  flake.nixosModules.security = {
    security = {
      virtualisation = {
        flushL1DataCache = "always";
      };
      forcePageTableIsolation = true;
      lockKernelModules = true;
      protectKernelImage = true;
      unprivilegedUsernsClone = config.virtualisation.containers.enable;
    };
  };
}

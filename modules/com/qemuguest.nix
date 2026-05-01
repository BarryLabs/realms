{
  flake.nixosModules.qemuguest = {modulesPath, ...}: {
    imports = [
      (modulesPath + "/profiles/qemu-guest.nix")
    ];
    services.qemuGuest = {
      enable = true;
    };
  };
}

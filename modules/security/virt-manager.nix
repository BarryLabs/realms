{config, ...}: {
  flake.nixosModules.virt-manager = {
    users.extraGroups.libvirtd.members = [config.yggdrasil.user];
    programs = {
      virt-manager = {
        enable = true;
      };
    };
    virtualisation = {
      libvirtd = {
        enable = true;
      };
    };
  };
}

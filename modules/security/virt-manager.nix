{config, ...}: {
  flake.nixosModules.virt-manager = {
    users.extraGroups.libvirtd.members = [config.client.user];
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

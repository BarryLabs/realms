{
  flake.nixosModules.docker = {pkgs, ... }: {
    boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
    users.users.chandler.extraGroups = ["docker"];
    virtualisation = {
      docker = {
        enable = true;
      };
    };
  };
}

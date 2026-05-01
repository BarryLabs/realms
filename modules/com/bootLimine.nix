{
  flake.nixosModules.bootLimine = {
    boot = {
      loader = {
        timeout = 5;
        limine.enable = true;
      };
    };
  };
}

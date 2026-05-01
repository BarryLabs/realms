{lib, ...}: {
  flake.nixosModules.zram = {
    zramSwap = {
      enable = true;
      algorithm = lib.mkDefault "zstd";
    };
  };
}

{
  flake.nixosModules.bash = {lib, ...}: {
    programs.bash = {
      completion = {
        enable = true;
      };
      shellAliases = lib.mkDefault {
        h = "history";
      };
    };
  };
}

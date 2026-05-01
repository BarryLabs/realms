{
  flake.nixosModules.direnv = {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
  flake.homeModules.direnv = {
    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

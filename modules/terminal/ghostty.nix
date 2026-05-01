{
  flake.nixosModules.ghostty = {pkgs, ...}: {
    environment.systemPackages = [pkgs.ghostty];
  };
  flake.homeModules.ghostty = {
    programs = {
      ghostty = {
        enable = true;
        enableZshIntegration = true;
        installVimSyntax = true;
        settings = {
          mouse-hide-while-typing = true;
        };
      };
    };
  };
}

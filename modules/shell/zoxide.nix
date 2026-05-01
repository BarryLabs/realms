{config, ...}: {
  flake.nixosModules.zoxide = {pkgs, ...}: {
    environment.systemPackages = [pkgs.zoxide];
  };
  flake.homeModules.zoxide = {
    programs = {
      zoxide = {
        enable = true;
        enableNushellIntegration =
          if config.programs.nushell.enable
          then true
          else false;
        enableZshIntegration =
          if config.programs.zsh.enable
          then true
          else false;
      };
    };
  };
}

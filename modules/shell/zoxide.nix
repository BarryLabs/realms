{config, ...}: {
  flake.nixosModules.zoxide = {pkgs, ...}: {
    environment.systemPackages = [pkgs.zoxide];
  };
  flake.homeModules.zoxide = {
    programs = {
      zoxide = {
        enable = true;
        enableNushellIntegration = config.programs.nushell.enable or false;
        enableZshIntegration = config.programs.zsh.enable or false;
      };
    };
  };
}

{self, ...}: {
  flake.nixosModules.zoxide = {pkgs, ...}: {
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.zoxide];
  };

  flake.homeModules.zoxide = {
    config,
    pkgs,
    ...
  }: {
    programs.zoxide = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.zoxide;
      enableNushellIntegration = config.programs.nushell.enable or false;
      enableZshIntegration = config.programs.zsh.enable or false;
    };
  };

  perSystem = {pkgs, ...}: {
    packages.zoxide = pkgs.zoxide;
  };
}

{self, ...}: {
  flake.nixosModules.suitesShell = {pkgs, ...}: {
    imports = [
      self.nixosModules.direnv
      self.nixosModules.helix
      self.nixosModules.yazi
    ];

    environment.systemPackages = with pkgs; [
      btop
      devenv
      fastfetch
      jujutsu
    ];
  };
}

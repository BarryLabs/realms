{self, ...}: {
  flake.nixosModules.programming = {pkgs, ...}: {
    imports = [
      self.nixosModules.direnv
      self.nixosModules.jujutsu
      self.nixosModules.opencode
    ];
    environment.systemPackages = with pkgs; [
      devenv
    ];
  };
}

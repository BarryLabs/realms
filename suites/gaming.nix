{self, ...}: {
  flake.nixosModules.suitesGaming = {pkgs, ...}: {
    imports = [
      self.nixosModules.steam
    ];
    environment.systemPackages = with pkgs; [
      mangohud
    ];
  };
}

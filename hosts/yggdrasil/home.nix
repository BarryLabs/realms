{self, ...}: {
  flake.homeModules.yggdrasilHome = {pkgs, ...}: {
    imports = [
      self.homeModules.content
      self.homeModules.programming
      self.homeModules.shell

      self.homeModules.mangohud
    ];
    home.packages = with pkgs; [
      runelite
      monero-gui
    ];
  };
}

{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    imports = [
      # Base
      self.nixosModules.base
      self.nixosModules.fhb
      self.nixosModules.fonts
      # Security
      self.nixosModules.apparmor
      # self.nixosModules.doas
      self.nixosModules.firejail
      self.nixosModules.gnupg
      self.nixosModules.jujutsu
      self.nixosModules.pam
      self.nixosModules.sudo-rs
      self.nixosModules.yubikey
      self.nixosModules.mullvad
      # Programs
      self.nixosModules.appimage
      self.nixosModules.localsend
      self.nixosModules.nix-ld
      self.nixosModules.steam
    ];
    environment.systemPackages = with pkgs; [
      obsidian
      thunderbird
      runelite
    ];
  };
}

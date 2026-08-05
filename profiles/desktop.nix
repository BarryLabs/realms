{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    imports = [
      self.nixosModules.base
      self.nixosModules.fonts
      self.nixosModules.pipewire
      self.nixosModules.appimage
      self.nixosModules.localsend
      self.nixosModules.nix-ld
      self.nixosModules.udisks
      self.nixosModules.apparmor
      self.nixosModules.firejail
      self.nixosModules.gnupg
      self.nixosModules.pam
      self.nixosModules.sudo-rs
      self.nixosModules.yubikey
    ];

    environment.systemPackages = with pkgs; [
      obsidian
      thunderbird
    ];
  };
}

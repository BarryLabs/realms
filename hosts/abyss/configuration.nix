{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.abyssConfiguration = {
    pkgs,
    config,
    # chaotic,
    ...
  }: {
    imports = [
      # Variables
      ./variables.nix

      # Hardware
      inputs.disko.nixosModules.disko
      self.nixosModules.abyssHardware

      # Sops
      self.nixosModules.sops
      
      # Chaotic Packages
      # chaotic.nixosModules.default

      # Profiles
      self.nixosModules.desktop
      self.nixosModules.content
      self.nixosModules.programming
      self.nixosModules.shell
      self.nixosModules.virtualisation

      # Packages
      self.nixosModules.bootLimine
      self.nixosModules.keepassxc
      self.nixosModules.nix
      self.nixosModules.goofcord
      self.nixosModules.netbird
      self.nixosModules.niri
      self.nixosModules.syncthing
      self.nixosModules.talosctl
      # self.nixosModules.zen
    ];
    users = {
      users = {
        ${config.abyss.user} = {
          isNormalUser = true;
          createHome = true;
          shell = pkgs.fish;
          home = config.abyss.home;
          description = config.abyss.desc;
          initialPassword = config.abyss.iniPass;
          extraGroups =
            [
            ]
            ++ (
              if config.security.doas.enable
              then ["doas"]
              else []
            )
            ++ (
              if config.security.sudo-rs.enable
              then ["wheel"]
              else []
            );
          openssh = {
            authorizedKeys = {
              keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICSv105WJyev8f1SA0p6WBLuEGxmdIUseZ5fXIZH8S3L"
                "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDY7o5pxFZ3Z8atKIwoT8HcyBbAYWu8312DNgypInARlAAAADHNzaDpuaXhmbGVldA== Kujo's Key"
                "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKGurGBrldhY5Vyzvi462uzVSFcq7+tWl/BFl9mThJHyAAAADHNzaDpuaXhmbGVldA== Koji's Key"
              ];
            };
          };
        };
      };
    };
  };
}

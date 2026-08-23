{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.abyssConfiguration = {
    pkgs,
    config,
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
      inputs.chaotic.nixosModules.default

      # Persistence
      self.nixosModules.impermanence
      self.nixosModules.imperm-options

      # Setup
      self.nixosModules.bootLimine
      self.nixosModules.laptop
      self.nixosModules.mango

      # Suites
      self.nixosModules.suitesContent
      self.nixosModules.suitesComm
      self.nixosModules.suitesDevops
      self.nixosModules.suitesGaming
      self.nixosModules.suitesMedia
      self.nixosModules.suitesSecurity
      self.nixosModules.suitesShell
      self.nixosModules.suitesVirtualization

      # Packages
      self.nixosModules.ghostty
      self.nixosModules.kdeconnect
      self.nixosModules.zen
      self.nixosModules.zsh
    ];
    ### Impermanence
    persistence = {
      enable = true;
      user = config.abyss.user;
      nukeRoot.enable = true;
      rootDevice = "/dev/mapper/crypt";
    };
    ### Users
    users = {
      users = {
        ${config.abyss.user} = {
          isNormalUser = true;
          createHome = true;
          shell = pkgs.zsh;
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
            )
            ++ (
              if config.virtualisation.podman.enable
              then ["podman"]
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

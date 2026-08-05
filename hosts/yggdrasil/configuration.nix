{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.yggdrasilConfiguration = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      ### Variables
      ./variables.nix

      ### Hardware
      inputs.disko.nixosModules.disko
      self.nixosModules.yggdrasilHardware

      ### Sops
      self.nixosModules.sops

      ### Chaotic Packages
      inputs.chaotic.nixosModules.default

      ### Setup
      self.nixosModules.bootLimine
      self.nixosModules.desktop
      self.nixosModules.nix
      self.nixosModules.niri

      ### Suites
      self.nixosModules.suitesComm
      self.nixosModules.suitesContent
      self.nixosModules.suitesDevops
      self.nixosModules.suitesMedia
      self.nixosModules.suitesSecurity
      self.nixosModules.suitesShell
      self.nixosModules.suitesGaming
      self.nixosModules.suitesVirtualization

      ### Packages
      self.nixosModules.coolercontrol
      self.nixosModules.flatpak
      self.nixosModules.foot
      self.nixosModules.ghostty
      self.nixosModules.kdeconnect
      self.nixosModules.superfile
      self.nixosModules.syncthing
      self.nixosModules.zen
      self.nixosModules.zsh
    ];
    ### Users
    users = {
      users = {
        ${config.client.user} = {
          isNormalUser = true;
          createHome = true;
          shell = pkgs.zsh;
          home = config.client.home;
          description = config.client.desc;
          initialPassword = config.client.iniPass;
          packages = with pkgs; [
            monero-gui
          ];
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

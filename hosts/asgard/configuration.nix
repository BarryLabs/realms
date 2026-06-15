{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.asgardConfiguration = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      ### Variables
      ./variables.nix

      ### Hardware
      inputs.disko.nixosModules.disko
      self.nixosModules.asgardHardware

      ### Sops
      self.nixosModules.sops

      ### Setup
      self.nixosModules.bootGRUB
      self.nixosModules.nix
      self.nixosModules.server
      self.nixosModules.sudo-rs
      self.nixosModules.qemuguest
      self.nixosModules.podman
      self.nixosModules.nfsv4
      self.nixosModules.asgardBackup
      self.nixosModules.intelGPU

      ### Containers
      self.nixosModules.oci-pgadmin
      self.nixosModules.oci-filebrowser
      self.nixosModules.oci-firefly
      self.nixosModules.oci-forgejo
      self.nixosModules.oci-immich
      self.nixosModules.oci-linkwarden
      self.nixosModules.oci-paperless
      self.nixosModules.oci-romm
      self.nixosModules.oci-syncthing
    ];
    ### Users
    users = {
      users = {
        ${config.asgard.user} = {
          isNormalUser = true;
          createHome = true;
          shell = pkgs.bash;
          home = config.asgard.home;
          description = config.asgard.desc;
          initialPassword = config.asgard.iniPass;
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
    ### State
    system.stateVersion = config.asgard.state;
  };
}

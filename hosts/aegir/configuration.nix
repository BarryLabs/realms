{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.aegirConfiguration = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      ### Variables
      ./variables.nix

      ### Hardware
      inputs.disko.nixosModules.disko
      self.nixosModules.aegirHardware

      ### Sops
      self.nixosModules.sops

      ### Setup
      self.nixosModules.bootGRUB
      self.nixosModules.nix
      self.nixosModules.server
      self.nixosModules.sudo-rs
      self.nixosModules.qemuguest
      self.nixosModules.podman
      self.nixosModules.intelGPU

      ### Containers
      self.nixosModules.oci-jellyseerr
      self.nixosModules.oci-jellyfin
      self.nixosModules.oci-prowlarr
      self.nixosModules.oci-radarr
      self.nixosModules.oci-sonarr
      self.nixosModules.oci-torrent
    ];
    ### Sops
    sops = {
      age = {
        keyFile = "/root/.config/sops/age/keys.txt";
      };
      defaultSopsFormat = "yaml";
      defaultSopsFile = ../../secrets/${config.aegir.host}.yaml;
    };
    ### Users
    users = {
      users = {
        ${config.aegir.user} = {
          isNormalUser = true;
          createHome = true;
          shell = pkgs.bash;
          home = config.aegir.home;
          description = config.aegir.desc;
          initialPassword = config.aegir.iniPass;
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

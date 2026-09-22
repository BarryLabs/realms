{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.bifrostConfiguration = {
    pkgs,
    config,
    ...
  }: {
    imports = [
      ### Variables
      ./variables.nix

      ### Profile
      self.nixosModules.server

      ### Setup
      self.nixosModules.bootGRUB
      self.nixosModules.qemuguest
    ];

    ### Users
    users = {
      users = {
        ${config.bifrost.user} = {
          isNormalUser = true;
          createHome = true;
          shell = pkgs.bash;
          home = config.bifrost.home;
          description = config.bifrost.desc;
          initialPassword = config.bifrost.iniPass;
          extraGroups =
            []
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

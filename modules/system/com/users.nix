{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.augs.com.users;
in
{
  options.augs.com.users.enable = mkEnableOption "Base Users Module";
  config = mkIf cfg.enable {
    users = {
      users = {
        ${config.var.user} = {
          isNormalUser = true;
          createHome = true;
          home = config.var.home;
          shell = pkgs.zsh;
          description = config.var.desc;
          initialPassword = config.var.iniPass;
          extraGroups =
            [
            ]
            ++ (
              if config.augs.com.doas.enable
              then [ "doas" ]
              else [ ]
            )
            ++ (
              if config.augs.com.sudo-rs.enable
              then [ "wheel" ]
              else [ ]
            );
          openssh = {
            authorizedKeys = {
              keys = lib.mkDefault [
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

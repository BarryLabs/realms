{ config
, lib
, ...
}:
with lib;
let
  cfg = config.augs.com.impermanence;
in
{
  options.augs.com.impermanence.enable = mkEnableOption "Impermanence Module for Realms";
  config = mkIf cfg.enable {
    # fileSystems = {
    #   "/" = {
    #     device = "/dev/hda2";
    #     fsType = "ext3";
    #     options = [ "data=journal" ];
    #   };
    #   "/boot" = {};
    #   "/home" = {};
    #   "/nix" = {};
    # };
    environment.persistence =
      if config.networking.hostName == "abyss" then { } else if config.networking.hostName == "yggdrasil" then {
        "/persist" = {
          hideMounts = true;
          directories = [
            "/etc/nixos"
            "/etc/ssh"
            "/etc/mullvad-vpn"
            "/etc/qemu"

            "/var/lib/nixos"

            "/var/lib/systemd/timers"
            "/var/lib/systemd/coredump"
          ];
          files = [
            "/etc/machine-id"
            "/root/.config/sops/age/keys.txt"
          ];
          users.${config.var.user} = {
            directores = [

              ".config/OpenRGB"
              ".config/Yubico"
              ".config/nushell"
              ".config/obs-studio"

              ".gnupg"
              ".mozilla"
              ".local"
              ".monero"
              ".runelite"
              ".ssh"
              ".steam"
              ".thunderbird"

              "Documents"
              "Downloads"
              "Music"
              "Pictures"
              "Projects"
              "Videos"

            ];
            files = [
              ".bash_history"
              ".zcompdump"
              ".zsh_history"
              ".zshenv"
              ".zshrc"
            ];
          };
        };
      } else { };
  };
}

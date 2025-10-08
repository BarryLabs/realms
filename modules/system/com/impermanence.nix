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
    fileSystems."/persist".neededForBoot = true;
    environment.persistence =
      if config.networking.hostName == "abyss" then { } else if config.networking.hostName == "yggdrasil" then {
        "/persist/system" = {
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
            directories = [

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
      } else if config.networking.hostName == "asgard" then {
        "/persist/system" = {
          hideMounts = true;
          directories = [
            "/etc/nixos"
            "/etc/ssh"
            "/srv"
            "/var/lib"
            "/var/log"
            # "/run/secrets"
            # "/root/.config/sops/age"
          ];
          files = [
            "/etc/machine-id"
            "/root/.config/sops/age/keys.txt"
          ];
        };
      } else { };
  };
}

{ config
, lib
, ...
}:
with lib;
let
  module = "client";
  cfg = config.augs.profile.${module};
in
{
  imports = [
    ../../../system
  ];
  options.augs.profile.${module}.enable = mkEnableOption "Base Client Profile";
  config = mkIf cfg.enable {
    augs = {
      com = {
        apparmor.enable = true;
        bootEFI.enable = true;
        cpu.enable = true;
        environment.enable = true;
        fhb.enable = true;
        fonts.enable = true;
        fstrim.enable = true;
        governor.enable = true;
        kernel.enable = true;
        locale.enable = true;
        network.enable = true;
        nh.enable = true;
        nix.enable = true;
        nix-ld.enable = true;
        nixpkgs.enable = true;
        nvidiaGPU.enable = true;
        openssh.enable = true;
        pam.enable = true;
        pipewire.enable = true;
        podman.enable = false;
        settings.enable = true;
        sops.enable = true;
        state.enable = true;
        sudo-rs.enable = true;
        timezone.enable = true;
        udisks.enable = true;
        users.enable = true;
        virt-manager.enable = true;
        waydroid.enable = true;
        xboxController.enable = true;
        xserver.enable = true;
        yubikey.enable = true;
        zram.enable = true;
        zsh.enable = true;
      };
    };
  };
}

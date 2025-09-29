{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.augs.com.kernel;
in
{
  options.augs.com.kernel.enable = mkEnableOption "Kernel Module for Realms";
  config = mkIf cfg.enable {
    boot = {
      extraModulePackages =
        if config.networking.hostName == "abyss" then
          [ config.boot.kernelPackages.v4l2loopback ]
        else if config.networking.hostName == "yggdrasil" then
          [ config.boot.kernelPackages.v4l2loopback ]
        else
          [ ];
      kernelPackages =
        if config.networking.hostName == "abyss" then
          pkgs.linuxPackages_zen
        else if config.networking.hostName == "yggdrasil" then
          pkgs.linuxPackages_zen
        else
          pkgs.linuxPackages_hardened;
      kernelModules =
        [
          "snd_aloop"
          "v4l2loopback"
        ]
        ++ (
          if config.networking.hostName == "abyss" then
            [ "kvm-intel" ]
          else if config.networking.hostName == "yggdrasil" then
            [ "kvm-amd" ]
          else
            [ ]
        );
      kernelParams = [
        "slab_nomerge"
        "page_poison=1"
        "debugfs=off"
        "page_alloc.shuffle=1"
      ];
      initrd = {
        availableKernelModules =
          if config.networking.hostName == "abyss" then
            [
              "nvme"
              "xhci_pci"
              "ahci"
              "usb_storage"
              "usbhid"
              "uas"
              "sd_mod"
            ]
          else if config.networking.hostName == "yggdrasil" then
            [
              "nvme"
              "xhci_pci"
              "ahci"
              "usb_storage"
              "usbhid"
              "uas"
              "sd_mod"
            ]
          else
            [
              "ata_piix"
              "uhci_hcd"
              "virtio_pci"
              "virtio_scsi"
              "sd_mod"
              "sr_mod"
            ];
      };
      kernelPatches =
        # if config.networking.hostName == "abyss" then
        #   [
        #     {
        #       name = "Rust Kernel Module";
        #       patch = null;
        #       features = {
        #         rust = true;
        #       };
        #     }
        #   ]
        # else if config.networking.hostName == "yggdrasil" then
        #   [
        #     {
        #       name = "Rust Kernel Module";
        #       patch = null;
        #       features = {
        #         rust = true;
        #       };
        #     }
        #   ]
        # else
        [ ];
    };
  };
}

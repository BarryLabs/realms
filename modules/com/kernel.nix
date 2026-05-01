{config, ...}: {
  flake.nixosModules.kernel = {pkgs, ...}: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      kernelModules = [
        "kvm-amd"
        "snd_aloop"
        "v4l2loopback"
      ];
      kernelParams = [
        "slab_nomerge"
        "page_poison=1"
        "debugfs=off"
        "page_alloc.shuffle=1"
      ];
      initrd = {
        availableKernelModules = [
          "ata_piix"
          "uhci_hcd"
          "virtio_pci"
          "virtio_scsi"
          "sd_mod"
          "sr_mod"
        ];
      };
    };
  };
}

{
  flake.nixosModules.yggdrasilHardware = {
    disko = {
      devices = {
        disk = {
          host = {
            type = "disk";
            device = "/dev/nvme0n1";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  size = "512M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = ["umask=0077"];
                  };
                };
                luks = {
                  size = "100%";
                  content = {
                    type = "luks";
                    name = "crypt";
                    settings.allowDiscards = true;
                    content = {
                      type = "btrfs";
                      extraArgs = ["-f"];
                      subvolumes = {
                        "/root" = {
                          mountpoint = "/";
                          mountOptions = ["compress=zstd" "noatime"];
                        };
                        "/persist" = {
                          mountpoint = "/persist";
                          mountOptions = ["compress=zstd" "noatime"];
                        };
                        "/nix" = {
                          mountpoint = "/nix";
                          mountOptions = ["compress=zstd" "noatime"];
                        };
                        "/home" = {
                          mountpoint = "/home";
                          mountOptions = ["compress=zstd" "noatime"];
                        };
                        "/swap" = {
                          mountpoint = "/.swapvol";
                          swap.swapfile.size = "32G";
                        };
                      };
                    };
                  };
                };
              };
            };
          };
          blaze = {
            type = "disk";
            device = "/dev/nvme1n1";
            content = {
              type = "gpt";
              partitions = {
                luks = {
                  size = "100%";
                  content = {
                    type = "filesystem";
                    format = "xfs";
                    mountpoint = "/persist/blaze";
                    mountOptions = [
                      "defaults"
                      "pquota"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}

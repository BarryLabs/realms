{
  disko = {
    devices = {
      disk = {
        host = {
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "1M";
                type = "EF02";
              };
              ESP = {
                size = "256M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              nix = {
                size = "10%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/nix";
                };
              };
              home = {
                size = "90%";
                content = {
                  type = "filesystem";
                  foramt = "ext4";
                  mountpoint = "/home";
                };
              };

              # root = {
              #   size = "100%";
              #   content = {
              #     type = "filesystem";
              #     format = "ext4";
              #     mountpoint = "/";
              #   };
              # };
            };
          };
        };
        blaze = {
          type = "disk";
          device = "/dev/nvme1n1";
          content = {
            type = "gpt";
            partitions = {
              main = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "xfs";
                  mountpoint = "/mnt/Blaze";
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
}

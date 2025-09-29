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
              ESP = {
                size = "128M";
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
                  name = "crypted";
                  settings = {
                    allowDiscards = true;
                  };
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
        sata = {
          type = "disk";
          device = "/dev/sda";
          content = {
            type = "gpt";
            partitions = {
              CryptStorage = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "Storage";
                  settings = {
                    allowDiscards = true;
                  };
                  content = {
                    type = "filesystem";
                    format = "xfs";
                    mountpoint = "/mnt/Block";
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

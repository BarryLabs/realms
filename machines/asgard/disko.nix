{
  disko = {
    devices = {
      disk = {
        host = {
          type = "disk";
          device = "/dev/sda";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "128M";
                type = "EF02";
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
        sata = {
          type = "disk";
          device = "/dev/sdb";
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
                    format = "ext4";
                    mountpoint = "/sata";
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

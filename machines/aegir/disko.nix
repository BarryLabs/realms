{
  disko = {
    devices = {
      disk = {
        zero = {
          type = "disk";
          device = "/dev/sda";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "256M";
                type = "EF02";
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "locked";
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
        one = {
          type = "disk";
          device = "/dev/sda1";
          content = {
            type = "gpt";
            partitions = {
              luks = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "xfs";
                  mountpoint = "/srv";
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

{ lib, ... }:
{
  disko.devices = {
    disk.vda = {
      type = "disk";
      device = "/dev/vda";
      content = {
        type = "gpt";
        partitions = {
          root = {
            type = "partition";
            size = "100%";
            fsType = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}

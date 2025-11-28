{
  disko.devices = {
    disk = {
      sdb = {
        type = "disk";
        device = "/dev/sdb";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "4G"; # Changed from 3.7G - disko doesn't accept decimals
              type = "EF00"; # EFI System partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };
            swap = {
              size = "8G"; # Changed from 7.5G
              content = {
                type = "swap";
                resumeDevice = true; # for hibernation support
              };
            };
            root = {
              size = "100%"; # Use remaining space
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      sda = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            home = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
              };
            };
          };
        };
      };
    };
  };
}

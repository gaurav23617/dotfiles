{
  disko.devices = {
    disk = {
      nvme1n1 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "8G";
              type = "EF00"; # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            swap = {
              size = "16G";
              type = "8200"; # Linux swap
              content = {
                type = "swap";
                randomEncryption = false;
              };
            };
            root = {
              size = "100%"; # Use all remaining space
              type = "8300"; # Linux filesystem
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            home = {
              size = "100%"; # Use the entire disk
              type = "8300"; # Linux filesystem
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/home";
                extraArgs = ["-f"]; # Force creation
                mountOptions = [
                  "compress=zstd"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}

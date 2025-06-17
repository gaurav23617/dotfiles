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
              content = {
                type = "btrfs";
                # Btrfs-specific options
                extraArgs = [ "-f" ]; # Force creation
                subvolumes = {
                  # Define a subvolume for /home
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  # You can add more subvolumes if needed
                  "/snapshots" = {
                    mountpoint = "/snapshots";
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
    };
  };
}

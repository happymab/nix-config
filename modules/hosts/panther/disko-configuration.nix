{
  devices = {
    disk = {
      main = {
        type = "disk";

        # CAUTION: Select the correct disk device! 
        device = "/dev/disk/by-id/ata-INTEL_SSDSCKJF180A5_SATA_180GB_CVTQ6176031L180A";  # External SSD 180GB for testing
        # device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_25133E806030";  # Primary SSD 2000GB
        
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
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
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                      "compress=zstd:3" # Good ratio/speed balance
                      "noatime" # Don't write access timestamps
                      "discard=async" # Background TRIM (modern SSDs)
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "discard=async"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                      "discard=async"
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
  };
}
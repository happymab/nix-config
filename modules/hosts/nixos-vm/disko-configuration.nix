{
  flake.diskoConfigurations.hostNixos-vm = {
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = "/dev/vda";
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
  };
}
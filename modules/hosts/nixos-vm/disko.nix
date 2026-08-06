{
  flake.diskoConfigurations.hostNixos-vm = {
    disko.devices = {
      disk.main = {
        device = "/dev/sdX";  # Will be replaced with real device during install
        type = "disk";
        content = {
          type = "gpt";
          partitions = {

            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            
            # EFI/Boot partition
            esp = {
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            # LUKS encrypted root partition
            root = {
              name = "root";
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                # disable settings.keyFile if you want to use interactive password entry
                #passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                  # keyFile = "/tmp/secret.key";
                };

                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];  # Override existing filesystem

                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
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
  };
}
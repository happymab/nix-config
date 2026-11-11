{ self, inputs, ... }: {

  flake.nixosModules.zram =
    { pkgs, lib, ... }:
    {
      services.zram-generator = {
        enable = true;

        settings = {
          "zram0" = {
            zram-size = "ram / 2";
            compression-algorithm = "zstd";
            swap-priority = 10;
            fs-type = "swap";
          };

          "zram1" = {
            zram-size = "ram / 2";
            compression-algorithm = "zstd";
            fs-type = "ext4";
            mount-point = "/tmp";
            options = "X-mount.mode=1777,discard";
          };
        };
      };

      # Required for zram for /tmp
      boot.supportedFilesystems = [ "ext4" ];

      # Give the setup unit access to the mkfs binaries + mount tooling.
      systemd.services."systemd-zram-setup@".path = [
        pkgs.util-linux
        pkgs.e2fsprogs
      ];
    };
}

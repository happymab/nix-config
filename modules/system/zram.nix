{ self, inputs, ... }: {

  flake.nixosModules.zram =
    { pkgs, lib, ... }:
    {
      services.zram-generator = {
        enable = true;

        # Zram swap
        settings = {
          "zram0" = {
            zram-size = "ram / 2"; # max. 50% of RAM
            compression-algorithm = "zstd";
            swap-priority = 10; # NixOS default priority for swap
            fs-type = "swap";
          };

          # Temp folder mounted as Zram
          # increased security, reduced SSD wear
          # equivalent to boot.tmp.useZram.enabled = true
          "zram1" = {
            zram-size = "ram / 2"; # max. 50% of RAM
            compression-algorithm = "zstd";
            fs-type = "ext4"; # use ext4 file system, ext2 is broken (nixpkgs#422415)
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

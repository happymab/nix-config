{ self, inputs, ... }: {

  flake.nixosModules.zram = { pkgs, ... }: {
    services.zram-generator = {
      enable = true;

      settings = {
        # Swap device — equivalent to zramSwap:
        # memoryPercent = "ram / 2" -> 50%, algorithm zstd, priority 10.
        "zram0" = {
          zram-size = "ram / 2";
          compression-algorithm = "zstd";
          swap-priority = 10;
          fs-type = "swap";
        };

        # /tmp device — equivalent to boot.tmp.useZram:
        # fs-type ext2 for efficiency
        "zram1" = {
          zram-size = "ram / 2";
          compression-algorithm = "zstd";
          fs-type = "ext2";
          mount-point = "/tmp";
          options = "X-mount.mode=1777,discard";
        };
      };
    };
  };
}

{ self, inputs, ... }: {

  flake.nixosModules.vmKernel = { pkgs, ... }: {

    # ── Kernel ──────────────────────────────────────────────────
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # ── Initrd modules for virtio boot devices ──────────────────
    boot.initrd.availableKernelModules = [
      "virtio_pci" # PCI transport — all other virtio devices sit on this
      "virtio_blk" # Root disk (virtio-blk)
      "virtio_scsi" # Alternative disk bus — include both, loader picks what exists
      "virtio_net" # NIC
      "virtio_console" # virtio-serial channel; qemu-guest-agent communicates over it
      "virtio_balloon" # Memory ballooning
      "virtio_rng" # Entropy from QEMU's RNG backend
    ];

    # Early KMS: get a proper framebuffer on virtio-gpu during initrd
    boot.initrd.kernelModules = [ "virtio_gpu" ];

    # ── Kernel parameters ───────────────────────────────────────
    boot.kernelParams = [
      # Headless / scripted debugging (use with `-serial` or `-nographic`):
      # "console=ttyS0,115200"
      #
      # Deliberately empty otherwise — no amd_pstate, no amdgpu TTM pools,
      # no IOMMU. The guest hardware is emulated Q35, not a real APU.
    ];

    # ── Graphics ────────────────────────────────────────────────
    hardware.graphics.enable = true;

    # ── Guest integration ───────────────────────────────────────
    services.qemuGuest.enable = true; # qemu-guest-agent + its virtio channel
    services.spice-vdagentd.enable = true; # Clipboard/adaptive resolution (SPICE display only)

  };
}

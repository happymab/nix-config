{ self, inputs, ... }: {

  flake.nixosModules.amdKernel = { pkgs, ... }: {

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.kernelParams = [
      # ── AMD ─────────────────────────────────────────────────────
      "amdgpu.ppfeaturemask=0xffffffff" # Already in gpu.nix —
      # flake-parts merges lists,
      # so this is additive & fine

      # ── IOMMU (for virtualization passthrough) ─────────────────
      "amd_iommu=on"
      "iommu=pt" # Passthrough mode

      # ── Sleep ──────────────────────────────────────────────────
      "mem_sleep_default=deep" # S3 deep sleep (verify support)
    ];

    # ── Kernel modules for this hardware ─────────────────────────
    boot.initrd.availableKernelModules = [
      "nvme"
      "ahci"
      "usb_storage"
      "sd_mod"
      "amdgpu" # Already in gpu.nix — merged automatically
    ];

    # ── Extra module loading ──────────────────────────────────────
    boot.kernelModules = [
      "kvm-amd" # AMD-V virtualization
      "amdgpu" # Ensure loaded
    ];

    # ── AMD microcode updates ────────────────────────────────────
    hardware.cpu.amd.updateMicrocode = true;

  };
}

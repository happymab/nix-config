{ self, inputs, ... }: {

  flake.nixosModules.amdKernel = { pkgs, ... }: {

    # Use latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # ── Initrd modules for early hardware support ────────────────
    boot.initrd.kernelModules = [
      "amdgpu" # Load GPU driver early for display initialization
      "nvme" # NVMe support
      "usb_storage" # For boot from a USB rescue drive
      "sd_mod" # SCSI disk driver. Needed by some NVMe controllers
    ];

    # ── Kernel parameters ─────────────────────────────────────────
    boot.kernelParams = [
      # CPU power management
      "amd_pstate=guided" # Guided autonomous frequency scaling

      # IOMMU for virtualization
      "amd_iommu=on" # Enable AMD IOMMU
      "iommu=pt" # Pass-through mode (isolated devices only)

      # Display/backlight
      "acpi_backlight=native" # Native backlight control (Lenovo)

      # GPU memory limits (critical for AI/LLM workloads)
      "amdgpu.gttsize=131072" # 128 GB GTT pool
      "ttm.pages_limit=33554432" # 32 GB TTM page limit
      "amdgpu.no_system_mem_limit=1" # Remove 27 GB ceiling

      # Virtualization
      "kvm.ignore_msrs=1" # Ignore unknown MSRs in VMs (prevents warnings)
      "kvm.report_ignored_msrs=0" # Don't spam dmesg with ignored MSR warnings

      # Optional: Uncomment if you experience GPU hangs under heavy load
      # "amdgpu.gpu_recover=1"
      # "amdgpu.runpm=0"
    ];

    # ── Additional kernel modules (loaded at runtime) ────────────
    boot.kernelModules = [
      "kvm-amd" # AMD-V virtualization module
      "ccp" # AMD Crypto Processor (for secure boot/TPM integration)
    ];

    # ── Extra module parameters ────────────────────────────────────
    boot.extraModprobeConfig = ''
      # Raise CPU thermal limits slightly (safe for cooling solutions)
      options k10temp tctrl_offset=5
    '';

    # ── Microcode updates ──────────────────────────────────────────
    hardware.cpu.amd.updateMicrocode = true;
  };

}

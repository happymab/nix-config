{

  flake.modules.nixos.amdKernel = { pkgs, lib, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.initrd.kernelModules = [ "amdgpu" ]; # early KMS

    boot.kernelParams = [
      "amd_pstate=active" # EPP; what PPD drives
      "iommu=pt" # NPU-safe; do NOT use amd_iommu=off
      "kvm.ignore_msrs=1"
      "kvm.report_ignored_msrs=0"
      "amdgpu.no_system_mem_limit=1" # KFD overcommit for multi-model ROCm
      # "amdgpu.gpu_recovery=1"                         # only if you hit GPU hangs
      # "acpi_backlight=native"                         # only if backlight keys misbehave
    ];

    # GTT/TTM sizing: use nix-amd-ai's gpuMemory option, NOT amdgpu.gttsize.
    boot.kernelModules = [ "kvm-amd" ]; # ccp auto-loads; k10temp option removed
    hardware.cpu.amd.updateMicrocode = true;
    hardware.enableRedistributableFirmware = lib.mkDefault true;
  };

}

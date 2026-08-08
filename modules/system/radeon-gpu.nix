{ config, lib, pkgs, ... }:

{
  flake.nixosModules.radeonGpu = { pkgs, ... }: {
    # ── Load amdgpu early for clean display init ────────────────
    boot.initrd.availableKernelModules = [ "amdgpu" ];

    # ── Explicit video driver (works with both X and Wayland) ────
    services.xserver.videoDrivers = [ "amdgpu" ];

    # ── Unlock PowerPlay for manual GPU tuning ──────────────────
    # boot.kernelParams = [
    #   "amdgpu.ppfeaturemask=0xffffffff"
    # ];

    # ── Graphics / Mesa ──────────────────────────────────────────
    hardware.graphics = {
      enable = true;
      # enable32Bit = true;    # 32-bit GL for Steam/Proton

      extraPackages = with pkgs; [
        rocmPackages.clr.icd           # OpenCL support
      ];

      # extraPackages32 = with pkgs.driversi686Linux; [
      #   amdvlk
      # ];
    };

    # ── Environment variables ────────────────────────────────────
    environment.sessionVariables = {
      # Prefer RADV by default (better gaming compat), fall back to AMDVLK
      AMD_VULKAN_ICD = "RADV";
    };

    # ── Utility packages ─────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      vulkan-tools       # vulkaninfo, vkcube
      clinfo             # Verify OpenCL setup
      radeontop          # Monitor GPU usage
      lact               # AMDGPU control panel (fan curves, clocks)
    ];
  };
}
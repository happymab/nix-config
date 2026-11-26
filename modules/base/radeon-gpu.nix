{
  flake.modules.nixos.radeonGpu = { pkgs, ... }: {
    # ── Load amdgpu early for clean display init ────────────────
    boot.initrd.availableKernelModules = [ "amdgpu" ];

    # ── Graphics / Mesa ──────────────────────────────────────────
    hardware.graphics = {
      enable = true;
      # enable32Bit = true;    # 32-bit GL for Steam/Proton

      extraPackages = with pkgs; [
        rocmPackages.clr.icd # OpenCL support
      ];
    };

    # ── Utility packages ─────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      vulkan-tools # vulkaninfo, vkcube
      clinfo # Verify OpenCL setup
      amdgpu_top # Monitor GPU usage
    ];

    services.lact.enable = true; # replaces the bare `lact` package# AMDGPU control panel (fan curves, clocks)

  };
}

{ self, inputs, ... }: {
  flake.nixosModules.amdNpuAi = { pkgs, lib, ... }: {
    imports = [ inputs.nix-amd-ai.nixosModules.default ];

    hardware.amd-npu = {
      enable = true;
      enableNPU = true; # default; set false for GPU-only hosts (see "Other hardware")
      enableFastFlowLM = true; # LLM inference on NPU (requires enableNPU)
      enableLemonade = true; # OpenAI-compatible API server
      enableROCm = true; # ROCm GPU backends (llamacpp + sd-cpp)
      enableVulkan = true; # Vulkan GPU backends (llamacpp + whispercpp)
      enableImageGen = true; # default true; set false to drop sd-cpp from closure
      lemonade.user = "lemonade";
    };

    # Create a dedicated user and group
    users.users.lemonade = {
      isSystemUser = true;
      group = "lemonade";
      createHome = true; # Lemonade needs ~/.cache/lemonade/ for config
      home = "/var/lib/lemonade"; # Put its home somewhere sensible
      extraGroups = [
        "video"
        "render"
      ]; # GPU/NPU device access
    };
    users.groups.lemonade = { };

    # ── Override GFX version for RDNA 3.5 (if needed) ────────────
    # The Radeon 880M may need HSA_OVERRIDE for some ROCm operations.
    # Uncomment if you encounter "unsupported GPU" errors
    # (shouldn't be required with newer versions):
    # systemd.services.lemond.environment.HSA_OVERRIDE_GFX_VERSION = "11.0.0";

    # Add binary cache (works only for trusted users)
    nix.settings = {
      substituters = [ "https://nix-amd-ai.cachix.org" ];
      trusted-public-keys = [ "nix-amd-ai.cachix.org-1:F4OU4vw/lV2oiG6SBHZ+nqjl4EFJuqI4X9A7pvaBmhQ=" ];
    };

  };
}

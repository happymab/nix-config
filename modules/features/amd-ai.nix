{ self, inputs, ... }: {
  flake.nixosModules.amdAi = { pkgs, lib, ... }: {
    imports = [ inputs.nix-amd-ai.nixosModules.default ];

    hardware.amd-npu = {
      enable = true;
      enableNPU = true; # default; set false for GPU-only hosts (see "Other hardware")
      enableFastFlowLM = true; # LLM inference on NPU (requires enableNPU)
      enableLemonade = true; # OpenAI-compatible API server
      enableROCm = true; # ROCm GPU backends (llamacpp + sd-cpp)
      enableVulkan = true; # Vulkan GPU backends (llamacpp + whispercpp)
      enableImageGen = true; # default true; set false to drop sd-cpp from closure
      lemonade.user = "mab";
    };

    users.users.mab.extraGroups = [
      "video"
      "render"
    ];

  };
}

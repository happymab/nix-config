{ self, ... }: {

  flake.modules.nixos.amdStrixPoint = { ... }: {

    # Import nixos modules
    imports = with self.modules.nixos; [
      amdKernel
      amdPower
      radeonGpu
      amdNpuAi
    ];

  };
}

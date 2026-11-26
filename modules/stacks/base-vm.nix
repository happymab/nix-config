{ self, inputs, ... }: {

  flake.modules.nixos.baseVm = { ... }: {

    imports = [
      # Default home-manager module
      inputs.home-manager.nixosModules.default

      # Packages from stable channel
      self.modules.nixos.stablePkgs

      # Base modules
      self.modules.nixos.nixConfig
      self.modules.nixos.networking
      # self.modules.nixos.bluetooth
      self.modules.nixos.security
      self.modules.nixos.btrfsFilesystem
      # self.modules.nixos.zram
      # self.modules.nixos.firmware
      self.modules.nixos.shell
      self.modules.nixos.audio
      # self.modules.nixos.input
      self.modules.nixos.locale
      self.modules.nixos.basePackages
      self.modules.nixos.flatpak

    ];

    # Common overlays

  };

}

{ self, inputs, ... }: {

  flake.modules.nixos.baseSystem = { ... }: {

    imports = [
      # Default home-manager module
      inputs.home-manager.nixosModules.default

      # Packages from stable channel
      self.modules.nixos.stablePkgs

      # Base modules
      self.modules.nixos.nixConfig
      self.modules.nixos.networking
      self.modules.nixos.bluetooth
      self.modules.nixos.security
      self.modules.nixos.btrfsFilesystem
      self.modules.nixos.zram
      self.modules.nixos.firmware
      self.modules.nixos.shell
      self.modules.nixos.audio
      self.modules.nixos.distrobox

    ];

    # Common overlays

  };

}

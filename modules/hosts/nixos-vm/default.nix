{ self, inputs, ... }: {

  flake.nixosConfigurations.nixos-vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.nixos-vmConfiguration
    ];
  };

}

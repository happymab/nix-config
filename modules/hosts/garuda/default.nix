{ self, inputs, ... }: {

  flake.nixosConfigurations.garuda = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.garudaConfiguration
    ];
  };

}

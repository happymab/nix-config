{ self, inputs, ... }: {

  flake.nixosConfigurations.garuda = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.garudaConfiguration
    ];
  };

}

{ self, inputs, ... }: {

  flake.nixosConfigurations.panther = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.pantherConfiguration
    ];
  };

}

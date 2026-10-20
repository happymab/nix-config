{ self, inputs, ... }: {
  perSystem = { system, ... }: {
    _module.args.stablePkgs = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };
}

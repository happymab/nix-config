# modules/stable-pkgs.nix
{ self, inputs, ... }: {
  flake.lib.stablePkgsFor =
    let
      # Each system is imported once, then cached in bySystem
      bySystem = {
        x86_64-linux = import inputs.nixpkgs-stable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        aarch64-linux = import inputs.nixpkgs-stable {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
      };
    in
    system: bySystem.${system};

  flake.nixosModules.stablePkgs = { pkgs, ... }: {
    _module.args.stablePkgs = self.lib.stablePkgsFor pkgs.stdenv.hostPlatform.system;
  };

  flake.homeManagerModules.stablePkgs = { pkgs, ... }: {
    _module.args.stablePkgs = self.lib.stablePkgsFor pkgs.stdenv.hostPlatform.system;
  };
}

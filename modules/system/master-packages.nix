{ self, inputs, ... }: {
  flake.lib.masterPkgsFor =
    let
      # Each system is imported once, then cached in bySystem
      bySystem = {
        x86_64-linux = import inputs.nixpkgs-master {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        aarch64-linux = import inputs.nixpkgs-master {
          system = "aarch64-linux";
          config.allowUnfree = true;
        };
        aarch64-darwin = import inputs.nixpkgs-master {
          system = "aarch64-darwin";
          config.allowUnfree = true;
        };
      };
    in
    system: bySystem.${system};

  flake.nixosModules.masterPkgs = { pkgs, ... }: {
    _module.args.masterPkgs = self.lib.masterPkgsFor inputs.pkgs.stdenv.hostPlatform.system;
  };

  flake.homeManagerModules.masterPkgs = { pkgs, ... }: {
    _module.args.masterPkgs = self.lib.masterPkgsFor inputs.pkgs.stdenv.hostPlatform.system;
  };
}

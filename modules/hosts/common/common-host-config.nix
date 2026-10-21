{ self, inputs, ... }: {

  flake.nixosModules.commonHostConfig =
    {
      pkgs,
      stablePkgs,
      ...
    }:
    {

      # ==== Common imports ========================================
      imports = [
        # ── Default home-manager module ───────────────────────────
        inputs.home-manager.nixosModules.default

        # ── Packages from stable channel ──────────────────────────
        self.nixosModules.stablePkgs
      ];

      # ==== Common overlays =======================================
      nixpkgs.overlays = [
        # ── VSCode extensions ─────────────────────────────────────
        inputs.nix-vscode-extensions.overlays.default
      ];

    };

}

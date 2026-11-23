{ self, inputs, ... }: {

  flake.modules.nixos.commonHostConfig =
    {
      pkgs,
      stablePkgs,
      ...
    }:
    {

      # ==== Common imports ========================================
      imports = [
        # ── Default home-manager module ───────────────────────────
        inputs.home-manager.modules.nixos.default

        # ── Packages from stable channel ──────────────────────────
        self.modules.nixos.stablePkgs

      ];

      # ==== Common overlays =======================================
      nixpkgs.overlays = [
        # ── VSCode extensions ─────────────────────────────────────
        inputs.nix-vscode-extensions.overlays.default
      ];

    };

}

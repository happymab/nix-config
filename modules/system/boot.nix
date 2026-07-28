{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, ... }: {
    # ── Plymouth for Silent Boot ──────────────────────────────────
    boot.plymouth = {
      enable = true;
      theme = "breeze"; # Matches KDE Plasma aesthetic

    };
  };
}

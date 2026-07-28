{ self, inputs, ... }: {
  flake.nixosModules.boot = { pkgs, ... }: {
    # ── Plymouth for Silent Boot ──────────────────────────────────
    boot.plymouth = {
      enable = true;
      theme = "breeze"; # Matches KDE Plasma aesthetic

      themePackages = with pkgs; [
        breeze # Default KDE theme (optional, but recommended)
      ];
    };

    # ── Console Font for Better Plymouth Integration ──────────────
    console.font = "ter-v16n";

    # Enable the framebuffer for Plymouth to work correctly
    console.useXFbFont = true;

    # ── Early Loading (important for lanzaboote + Plymouth) ───────
    # Make sure Plymouth can show early boot messages
    boot.initrd.systemd.enable = true;

  };
}

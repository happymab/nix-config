{ self, inputs, ... }: {
  flake.modules.nixos.boot = { pkgs, ... }: {
    # ── Plymouth for Silent Boot ─────────────────────────────────
    boot.plymouth = {
      enable = true;
      theme = "breeze"; # Matches KDE Plasma aesthetic

      themePackages = with pkgs; [
        breeze # Default KDE theme
      ];
    };

    # ── Kernel Parameters for Plymouth ────────────────────────────
    # Note: Don't add "quiet" or "splash" manually — Plymouth handles this
    boot.kernelParams = [
      # Do NOT duplicate "quiet splash" here
    ];

    # ── Console Font for Better Plymouth Integration ──────────────
    boot.consoleFonts = [
      {
        unit = "console-setup.service";
        path = "${pkgs.terminus_font}/share/consolefonts/ter-v16n.psfu";
      }
    ];

    # ── Early Loading (important for lanzaboote + Plymouth) ──────
    # Make sure Plymouth can show early boot messages
    boot.initrd.systemd.enable = true;

    # ── Boot Loader ───────────────────────────────────────────────
    # Note: Secure boot / lanzaboote is handled by self.nixosModules.secureboot
    # or self.nixosModules.securebootMeasured
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}

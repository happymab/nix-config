{ self, inputs, ... }: {
  flake.nixosModules.amdPower = { pkgs, ... }: {

    # ── Power Profiles Daemon (AMD-optimized for Strix Point) ───
    services.power-profiles-daemon.enable = true;

    # ── Disable conflicting managers ─────────────────────────────
    services.auto-cpufreq.enable = false;
    services.tlp.enable = false;

    # ── Thermal management (still required) ──────────────────────
    services.thermald.enable = true;

    # ── Packages ─────────────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      powertop # Diagnosis
      powerprofilesctl # CLI to check/set profile
    ];
  };
}

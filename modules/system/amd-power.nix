{ self, inputs, ... }: {
  flake.nixosModules.amdPower = { pkgs, ... }: {

    # ── Use power profiles daemon (recommended over auto-cpufreq)
    services.power-profiles-daemon.enable = true;

    # ── Disable conflicting auto-cpufreq and tlp ─────────────────
    services.auto-cpufreq.enable = false;
    services.tlp.enable = false;

    # ── Useful packages ──────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      powertop # Diagnose power consumers
      auto-cpufreq # CLI companion
    ];
  };
}

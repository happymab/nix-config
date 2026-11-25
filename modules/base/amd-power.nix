{
  flake.modules.nixos.amdPower = { ... }: {

    services.power-profiles-daemon.enable = true;
    services.thermald.enable = false; # Intel tool; no-op on Ryzen
    services.tlp.enable = false;
    services.auto-cpufreq.enable = false;

  };
}

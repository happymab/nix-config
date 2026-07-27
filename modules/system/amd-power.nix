{ config, lib, pkgs, ... }:

{
  flake.nixosModules.amdPower = { pkgs, ... }: {
    # ── Thermal daemon (Intel/AMD thermal management) ──────────
    services.thermald.enable = true;

    # ── auto-cpufreq (replace power-profiles-daemon) ─────────────
    services.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };

    # ── Disable conflicting power-profiles-daemon ────────────────
    services.power-profiles-daemon.enable = false;

    # ── AMD microcode updates ────────────────────────────────────
    hardware.cpu.amd.updateMicrocode = true;

    # ── Battery charge threshold (Lenovo, 80% limit) ────────────
    # Prolongs battery lifespan by capping charge at 80%.
    # Verify the sysfs path exists: ls /sys/class/power_supply/BAT*/charge_control_end_threshold
    systemd.services.battery-charge-threshold = {
      description = "Set battery charge threshold to 80%";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 80 > /sys/class/power_supply/BAT*/charge_control_end_threshold'";
      };
      wantedBy = [ "multi-user.target" ];
    };

    # ── Useful packages ──────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      powertop           # Diagnose power consumers
      auto-cpufreq       # CLI companion
    ];
  };
}
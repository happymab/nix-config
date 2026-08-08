{ self, inputs, ... }: {

  flake.nixosModules.btrfsFilesystem =
    {
      config,
      lib,
      pkgs,
      ...

    }:
    {
      # ── Btrfs mount options ──────────────────────────────────────
      fileSystems."/" = {
        options = [
          "compress=zstd:3" # Good ratio/speed balance
          "noatime" # Don't write access timestamps
          "discard=async" # Background TRIM (modern SSDs)
        ];
      };

      # Apply same options to subvolumes if they're separate mounts
      fileSystems."/home" = {
        options = [
          "compress=zstd:3"
          "noatime"
          "discard=async"
        ];
      };

      fileSystems."/nix" = {
        options = [
          "compress=zstd:3"
          "noatime"
          "discard=async"
        ];
      };

      # ── Periodic TRIM (belt-and-suspenders with discard=async) ──
      services.fstrim = {
        enable = true;
        interval = "weekly";
      };

      # ── Btrfs scrub timer (data integrity) ──────────────────────
      systemd.services.btrfs-scrub = {
        description = "Scrub Btrfs filesystem for data integrity";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.btrfs-progs}/bin/btrfs scrub start -B /";
          Nice = 19; # Lowest priority — don't compete with real work
          IOSchedulingClass = "idle";
        };
      };

      systemd.timers.btrfs-scrub = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "monthly";
          Persistent = true; # Catch up if missed during sleep/shutdown
        };
      };

      # ── Support packages ─────────────────────────────────────────
      environment.systemPackages = with pkgs; [
        btrfs-progs
        compsize # Inspect compression ratios: `compsize /path`
      ];

    };
}

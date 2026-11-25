{ self, inputs, ... }: {

  flake.modules.nixos.garudaConfiguration =
    {
      pkgs,
      lib,
      disko,
      ...
    }:
    {

      imports = [
        # ── Hardware ──────────────────────────────────────────────
        self.modules.nixos.hostGaruda

        # ── Common host config ────────────────────────────────────
        self.modules.nixos.commonHostConfig

        # ── Base config ────────────────────────────────────
        self.modules.nixos.baseDesktop

        # ── Disko ─────────────────────────────────────────────────
        self.modules.nixos.diskoBtrfsLuks

        # ── Boot manager ──────────────────────────────────────────
        self.modules.nixos.securebootMeasured
        self.modules.nixos.silentBoot

        # ── System modules ────────────────────────────────────────
        self.modules.nixos.security
        self.modules.nixos.btrfsFilesystem
        self.modules.nixos.zram
        self.modules.nixos.radeonGpu
        self.modules.nixos.amdNpuAi
        self.modules.nixos.amdPower
        self.modules.nixos.firmware
        self.modules.nixos.amdKernel
        self.modules.nixos.nixConfig
        self.modules.nixos.networking
        self.modules.nixos.bluetooth
        self.modules.nixos.audio
        self.modules.nixos.locale
        self.modules.nixos.basePackages
        self.modules.nixos.desktopKde

        self.modules.nixos.umbriel

        # ── User and Home configuration ───────────────────────────
        self.modules.nixos.userMab

        # ── Features ──────────────────────────────────────────────
        self.modules.nixos.flatpak
        self.modules.nixos.virtualization
        self.modules.nixos.podman
        self.modules.nixos.distrobox
      ];

      # Disko drive definition
      # CAUTION: Select the correct disk device!
      # disko.devices.disk.main.device = "/dev/disk/by-id/ata-INTEL_SSDSCKJF180A5_SATA_180GB_CVTQ6176031L180A";  # External SSD 180GB for testing
      disko.devices.disk.main.device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_25133E806030"; # Primary SSD 2000GB

      # Define the host name
      networking.hostName = "garuda";

      # This option defines the first version of NixOS you installed on this machine
      # Used to maintain compatibility with application data created on older versions
      #
      # DO NOT CHANGE THIS AFTER INITIAL INSTALL unless you've carefully migrated data
      system.stateVersion = "26.05"; # Read the comment!

    };

}

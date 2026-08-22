{ self, inputs, ... }: {

  flake.nixosModules.garudaConfiguration = { pkgs, lib, disko, ... }: {

    imports = [
      # ── Hardware ──────────────────────────────────────────────
      self.nixosModules.hostGaruda

      # ── Disko ─────────────────────────────────────────────────
      self.nixosModules.diskoBtrfsLuks

      # ── Boot manager ──────────────────────────────────────────
      self.nixosModules.securebootMeasured
      self.nixosModules.silentBoot

      # ── System modules ────────────────────────────────────────
      self.nixosModules.security
      self.nixosModules.btrfsFilesystem
      self.nixosModules.zramSwap
      self.nixosModules.radeonGpu
      self.nixosModules.amdNpuAi
      self.nixosModules.amdPower
      self.nixosModules.firmware
      self.nixosModules.amdKernel
      self.nixosModules.nixConfig
      self.nixosModules.networking
      self.nixosModules.bluetooth
      self.nixosModules.audio
      self.nixosModules.locale
      self.nixosModules.shell
      self.nixosModules.basePackages
      self.nixosModules.desktopKde

      # ── User and Home configuration ───────────────────────────
      self.nixosModules.userMab

      # ── Features ──────────────────────────────────────────────
      self.nixosModules.flatpak
      self.nixosModules.virtualization
      self.nixosModules.podman
      self.nixosModules.distrobox
    ];

    # Disko drive definition
    # CAUTION: Select the correct disk device! 
    # disko.devices.disk.main.device = "/dev/disk/by-id/ata-INTEL_SSDSCKJF180A5_SATA_180GB_CVTQ6176031L180A";  # External SSD 180GB for testing
    disko.devices.disk.main.device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_25133E806030";  # Primary SSD 2000GB


    # Define the host name
    networking.hostName = "garuda";

    # This option defines the first version of NixOS you installed on this machine
    # Used to maintain compatibility with application data created on older versions
    #
    # DO NOT CHANGE THIS AFTER INITIAL INSTALL unless you've carefully migrated data
    system.stateVersion = "26.05"; # Read the comment!

  };

}

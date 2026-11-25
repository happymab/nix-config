{ self, ... }: {

  flake.modules.nixos.pantherConfiguration = { ... }: {

    # Import Home-Manager module for garuda (defined below)
    home-manager.sharedModules = [
      self.modules.homeManager.pantherConfiguration
    ];

    imports = [
      # ── Hardware ──────────────────────────────────────────────
      self.modules.nixos.pantherHwConfiguration

      # ── Base config ────────────────────────────────────
      self.modules.nixos.kdeDesktop
      self.modules.nixos.amdStrixPoint
      self.modules.nixos.development

      # ── Disko ─────────────────────────────────────────────────
      self.modules.nixos.diskoBtrfsLuks

      # ── Boot manager ──────────────────────────────────────────
      self.modules.nixos.systemdBoot
      self.modules.nixos.silentBoot

      # ── User and Home configuration ───────────────────────────
      self.modules.nixos.userMab

    ];

    # Disko drive definition
    # CAUTION: Select the correct disk device!
    disko.devices.disk.main.device =
      "/dev/disk/by-id/ata-INTEL_SSDSCKJF180A5_SATA_180GB_CVTQ6176031L180A"; # External SSD 180GB for testing
    # disko.devices.disk.main.device = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_2000GB_25133E806030";  # Primary SSD 2000GB

    # Define the host name
    networking.hostName = "panther";

    # This option defines the first version of NixOS you installed on this machine
    # Used to maintain compatibility with application data created on older versions
    #
    # DO NOT CHANGE THIS AFTER INITIAL INSTALL unless you've carefully migrated data
    system.stateVersion = "26.05"; # Read the comment!

  };

  flake.modules.homeManager.pantherConfiguration = { ... }: {

    # Required for home-manager to activate
    home.stateVersion = "26.05"; # match this to the HM/NixOS version you started with

  };
}

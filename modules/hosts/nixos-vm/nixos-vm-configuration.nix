{ self, ... }: {

  flake.modules.nixos.nixos-vmConfiguration = { ... }: {

    # Import Home-Manager module for garuda (defined below)
    home-manager.sharedModules = [
      self.modules.homeManager.nixos-vmConfiguration
    ];

    imports = [
      # ── Hardware ──────────────────────────────────────────────
      self.modules.nixos.nixos-vmHwConfiguration

      # ── Base config ────────────────────────────────────
      self.modules.nixos.umbrielVm
      self.modules.nixos.vmKernel

      # ── Disko ─────────────────────────────────────────────────
      self.modules.nixos.diskoBtrfsLuks

      # ── Boot manager ──────────────────────────────────────────
      self.modules.nixos.secureboot
      self.modules.nixos.silentBoot

      # ── User and Home configuration ───────────────────────────
      self.modules.nixos.userMab

      # ── Additional modules ────────────────────────────────────
      self.modules.nixos.devTools
      self.modules.nixos.vscode

    ];

    # Disko drive definition
    disko.devices.disk.main.device = "/dev/vda";

    # Define the hostname
    networking.hostName = "nixos-vm";

    # This option defines the first version of NixOS you installed on this machine
    # Used to maintain compatibility with application data created on older versions
    #
    # DO NOT CHANGE THIS AFTER INITIAL INSTALL unless you've carefully migrated data
    system.stateVersion = "26.05"; # Read the comment!

  };

  flake.modules.homeManager.nixos-vmConfiguration = { ... }: {

    # Required for home-manager to activate
    home.stateVersion = "26.05"; # match this to the HM/NixOS version you started with

  };
}

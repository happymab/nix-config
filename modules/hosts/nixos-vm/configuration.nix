{ self, inputs, ... }: {

  flake.modules.nixos.nixos-vmConfiguration =
    {
      pkgs,
      lib,
      disko,
      ...
    }:
    {

      imports = [
        # ── Hardware ──────────────────────────────────────────────
        self.modules.nixos.hostNixos-vm

        # ── Common host config ────────────────────────────────────
        self.modules.nixos.commonHostConfig

        # ── Disko ─────────────────────────────────────────────────
        self.modules.nixos.diskoBtrfsLuks

        # ── Boot manager ──────────────────────────────────────────
        self.modules.nixos.secureboot
        self.modules.nixos.silentBoot

        # ── System modules ────────────────────────────────────────
        self.modules.nixos.vmKernel
        self.modules.nixos.security
        self.modules.nixos.btrfsFilesystem
        self.modules.nixos.zram
        self.modules.nixos.nixConfig
        self.modules.nixos.networking
        self.modules.nixos.audio
        self.modules.nixos.locale
        self.modules.nixos.basePackages
        self.modules.nixos.desktopKde

        self.modules.nixos.niri
        self.modules.nixos.umbriel

        # ── User and Home configuration ───────────────────────────
        self.modules.nixos.userMab

        # ── Features ──────────────────────────────────────────────
        self.modules.nixos.flatpak
        self.modules.nixos.podman
        self.modules.nixos.distrobox
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

}

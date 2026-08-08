{ self, inputs, ... }: {

  flake.nixosModules.nixos-vmConfiguration = { pkgs, lib, disko, ... }: {

    imports = [
      # ── Hardware ──────────────────────────────────────────────
      self.nixosModules.hostNixos-vm

      # ── Disko ─────────────────────────────────────────────────
      # self.nixosModules.diskoBtrfsLuks

      # ── Boot manager ──────────────────────────────────────────
      self.nixosModules.secureboot
      self.nixosModules.silentBoot

      # ── System modules ────────────────────────────────────────
      self.nixosModules.security
      self.nixosModules.btrfsFilesystem
      self.nixosModules.zramSwap
      self.nixosModules.nixConfig
      self.nixosModules.networking
      self.nixosModules.audio
      self.nixosModules.locale
      self.nixosModules.shell
      self.nixosModules.basePackages
      self.nixosModules.desktopKde

      # ── Home-manager ──────────────────────────────────────────
      self.nixosModules.myHomeManager
      self.nixosModules.mabUser

      # ── Features ──────────────────────────────────────────────
      self.nixosModules.niri
      self.nixosModules.docker
      self.nixosModules.podman
      self.nixosModules.distrobox
    ];

    # Disko drive definition
    disko = self.nixosModules.diskoBtrfsLuks;
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

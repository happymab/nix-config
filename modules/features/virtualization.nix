{ config, lib, pkgs, ... }:

{
  flake.nixosModules.virtualization = { pkgs, ... }: {
    # ── Libvirt ──────────────────────────────────────────────────
    virtualisation.libvirtd.enable = true;

    # Use virtio for better performance
    virtualisation.libvirtd.onShutdown = "shutdown";

    # ── Packages ─────────────────────────────────────────────────
    environment.systemPackages = with pkgs; [
      virt-manager      # GUI for managing VMs
      virt-viewer       # VM console viewer
      qemu              # Emulator
      swtpm             # TPM emulation for VMs (useful with Secure Boot VMs)
    ];

    # ── Ensure your user is in libvirtd group ────────────────────
    # (This goes in your host definition, not here — the dendritic
    # pattern keeps user definitions in the host module)
    # users.users.yourusername.extraGroups = [ "libvirtd" ];
  };
}
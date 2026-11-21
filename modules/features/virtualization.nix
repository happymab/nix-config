{ self, inputs, ... }: {
  flake.nixosModules.virtualization = { pkgs, config, ... }: {

    # Libvirt
    virtualisation.libvirtd = {
      enable = true;

      # Enable virtual TPM
      qemu.swtpm.enable = true;
    };

    virtualisation.libvirtd.onShutdown = "shutdown";

    # Packages
    environment.systemPackages = with pkgs; [
      virt-manager # GUI for managing VMs
      virt-viewer # VM console viewer
      qemu # Emulator
      swtpm # TPM emulation for VMs (useful with Secure Boot VMs)
    ];

    # ── Ensure your user is in libvirtd group ────────────────────
    # (This goes in your host definition, not here — the dendritic
    # pattern keeps user definitions in the host module)
    # users.users.yourusername.extraGroups = [ "libvirtd" ];

    let userName = config.

    # For plain `nh os build-vm`
    virtualisation.vmVariant = {
      virtualisation.cores = 3;
      virtualisation.memorySize = 8192; # MiB
    };

    # For `nh os build-vm --with-bootloader`
    virtualisation.vmVariantWithBootLoader = {
      virtualisation.cores = 4;
      virtualisation.memorySize = 8192;
    };
  };
}

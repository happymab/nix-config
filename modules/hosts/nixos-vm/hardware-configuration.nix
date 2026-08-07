{ self, inputs, ... }: {

  flake.nixosModules.nixos-vmHardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/profiles/qemu-guest.nix")
      ];

      boot.initrd.availableKernelModules = [
        "ahci"
        "xhci_pci"
        "virtio_pci"
        "virtio_scsi"
        "sr_mod"
        "virtio_blk"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };

}

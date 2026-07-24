{ self, inputs, ... }: {

  flake.nixosModules.pantherHardware = { config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "uas" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-b1b9b962-5559-4f25-9104-6c29f0f2da77";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."luks-b1b9b962-5559-4f25-9104-6c29f0f2da77".device = "/dev/disk/by-uuid/b1b9b962-5559-4f25-9104-6c29f0f2da77";

  fileSystems."/home" =
    { device = "/dev/mapper/luks-b1b9b962-5559-4f25-9104-6c29f0f2da77";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/mapper/luks-b1b9b962-5559-4f25-9104-6c29f0f2da77";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/0003-81A1";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
};

}

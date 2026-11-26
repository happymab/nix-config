{
  flake.modules.nixos.firmware = { ... }: {

    # Firmware update daemon (LVFS)
    services.fwupd.enable = true;

    # Include all redistributable firmware blobs
    # Essential for recent AMD silicon — GPU microcode, Wi-Fi, sensors
    hardware.enableRedistributableFirmware = true;

    # Enable proprietary/non-redistributable firmware:
    hardware.enableAllFirmware = true;

  };
}

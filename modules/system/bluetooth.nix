{ self, inputs, ... }: {
  flake.nixosModules.bluetooth = { pkgs, ... }: {
    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false; # Set to true if you want BT to start automatically on boot

      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };
}

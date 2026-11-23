{ self, inputs, ... }: {
  flake.modules.nixos.bluetooth = { pkgs, ... }: {
    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          # Enable newest features (may help with new devices)
          Experimental = true;
          KernelExperimental = true;
          # For faster connections, but may increase power consumption
          FastConnectable = false;
        };
      };
    };
  };
}

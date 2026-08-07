{ self, inputs, ... }: {
  flake.nixosModules.bluetooth = { pkgs, ... }: {
    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };
}

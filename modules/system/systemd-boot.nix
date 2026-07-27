{ self, inputs, ... }: {
  flake.nixosModules.systemdBoot = { pkgs, lib, ... }: {

    boot = {

      # Use systemd bootloader
      loader.systemd-boot = {
        enable = true;

        # Keep 10 generations
        configurationLimit = 10;
      };

    };

  };
}

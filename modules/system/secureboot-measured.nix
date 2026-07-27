{ self, inputs, ... }: {
  flake.nixosModules.securebootMeasured = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.secureboot
    ];

    boot.lanzaboote = {

      # Enable measured boot
      measuredBoot = {
        enable = true;
        pcrs = [
          0
          4
          7
        ];
      };

      # 8 generations is the limit for measured boot
      configurationLimit = lib.mkForce 8;

    };

    # Required for measured boot
    boot.initrd.systemd.enable = true;

  };
}

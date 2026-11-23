{ self, inputs, ... }: {
  flake.modules.nixos.securebootMeasured = { pkgs, lib, ... }: {
    imports = [
      self.modules.nixos.secureboot
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

      # 4 generations is the limit for measured boot
      configurationLimit = lib.mkForce 4;

    };

  };
}

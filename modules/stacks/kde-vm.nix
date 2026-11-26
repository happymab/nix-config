{ self, ... }: {

  flake.modules.nixos.kdeVm = { ... }: {

    imports = with self.modules.nixos; [
      baseVm
      kde
    ];

  };
}

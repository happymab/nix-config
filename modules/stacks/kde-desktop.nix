{ self, ... }: {

  flake.modules.nixos.kdeDesktop = { ... }: {

    imports = with self.modules.nixos; [
      baseSystem
      kde
    ];

  };
}

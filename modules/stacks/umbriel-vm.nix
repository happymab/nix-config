{ self, ... }: {

  flake.modules.nixos.umbrielVm = { ... }: {

    imports = with self.modules.nixos; [
      baseVm
      kde
      umbriel
      noctalia
    ];

  };
}

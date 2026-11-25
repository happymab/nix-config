{ self, ... }: {

  flake.modules.nixos.umbrielDesktop = { ... }: {

    imports = with self.modules.nixos; [
      kde
      umbriel
    ];

  };
}

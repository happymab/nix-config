{ self, ... }: {

  flake.modules.nixos.kdeDesktop = { ... }: {

    imports = with self.modules.nixos; [
      shell
      distrobox
    ];

  };
}

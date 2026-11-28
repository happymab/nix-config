{ self, ... }: {

  flake.modules.nixos.mediaCreate = { ... }: {

    # Import nixos modules
    imports = with self.modules.nixos; [
      obsStudio
    ];

  };
}

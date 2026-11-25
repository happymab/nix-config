{ self, ... }: {

  flake.modules.nixos.baseDesktop =
    { ... }:
    {

      imports = with self.modules.nixos; [
        shell
      ];

    };

}

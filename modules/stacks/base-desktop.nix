{ self, inputs, ... }: {

  flake.modules.nixos.baseDesktop =
    {
      pkgs,
      lib,
      ...
    }:
    {

    };

}

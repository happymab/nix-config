{ self, inputs, ... }: {

  flake.modules.nixos.commonHostConfig =
    {
      pkgs,
      stablePkgs,
      ...
    }:
    {
    };

}

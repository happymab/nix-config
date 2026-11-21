{ self, inputs, ... }: {

  flake.nixosModules.commonHostConfig =
    {
      pkgs,
      stablePkgs,
      ...
    }:
    {
    };

}

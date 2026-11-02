{ self, inputs, ... }: {
  flake.nixosModules.artCraft =
    {
      pkgs,
      lib,
      artcraft,
      ...
    }:
    {

      imports = [ artcraft.nixosModules.default ];

      programs.artcraft = {
        enable = true;
        apps = [
        ];
      };

      hardware.graphics.enable = true;
    };

  flake.homeModules.artCraft =
    {
      pkgs,
      lib,
      artcraft,
      ...
    }:
    {
      imports = [ artcraft.homeManagerModules.default ];

      programs.artcraft = {
        enable = true;
        apps = [
        ];
      };
    };
}

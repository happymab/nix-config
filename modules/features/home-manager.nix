{ self, inputs, ... }: {

  # This module imports and configures home-manager
  flake.nixosModules.myHomeManager = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.default # import official home-manager NixOS module
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };

}

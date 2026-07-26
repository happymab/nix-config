{ self, inputs, ... }: {

  # This module imports and configures home-manager
  flake.nixosModules.myLanzaboote = { pkgs, lanzaboote, ... }: {
    imports = [
      lanzaboote.nixosModules.lanzaboote # import lanzaboote NixOs module
    ];
  };

}

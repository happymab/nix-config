{ self, inputs, ... }: {

  # This module imports and configures disko
  flake.nixosModules.myDisko = { pkgs, ... }: {
    imports = [
      inputs.disko.nixosModules.disko # import official disko NixOS module
    ];
  };

}

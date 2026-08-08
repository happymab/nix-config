{ self, inputs, ... }: {

  # This module imports and configures disko
  flake.nixosModules.myDisko = { pkgs, ... }: {
    imports = [
      inputs.disko.nixosModules.disko # import official disko NixOS module
    ];
  };

  # This option allows to define disko configurations for different hosts in different flakes
  # Required for merging disko configurations from different flakes into one configuration
  options.flake.diskoConfigurations = inputs.lib.mkOption {
    type = inputs.lib.types.attrsOf inputs.lib.types.anything;
    default = {};
  };  

}

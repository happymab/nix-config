{ inputs, ... }: {

  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.flake-parts.flakeModules.easyOverlay

    # adds home-manager options to flake-parts
    # inputs.home-manager.flakeModules.home-manager
  ];

  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
    "aarch64-darwin"
  ];
}

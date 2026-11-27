{
  inputs = {
    # unstable channel as default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # stable channel as additional input
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

    # Split your flake.nix into focused units and take care of system
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Recursively import Nix modules from a directory
    import-tree.url = "github:vic/import-tree";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secure Boot & Measured Boot for NixOS
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wayland compositor with scrolling, dwindle, master, and stacking layouts (from noctalia.dev)
    umbriel = {
      url = "github:noctalia-dev/umbriel/cachix"; # Tracking Cachix branch to avoid commits that are not available cached
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia shell
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # AMD NPU drivers and local lemonade AI server
    nix-amd-ai.url = "github:noamsto/nix-amd-ai";

    # Luciole File Manager (from noctalia.dev)
    luciole = {
      url = "github:noctalia-dev/luciole";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSCode extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Helium Browser
    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}

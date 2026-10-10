{ pkgs, lib, config, ... }:

{
  # === Environment Variables ===
  env = {
    NIX_CONFIG = ''
      experimental-features = nix-command flakes
      extra-substituters = https://cache.nixos.org
    '';
    HOME_MANAGER_BACKUP_DIR = "~/backup";
  };

  # === Core Packages ===
  packages = with pkgs; [
    # Nix Tooling
    nix
    nixfmt-classic        # Or nixfmt-rfc-style for RFC 87 style
    deadnix               # Dead code removal
    statix                # Linting
    nixpkgs-fmt           # Alternative formatter

    # Language servers
    nil                   # Nix language server
    nixd                  # Alternative/experimental Nix LSP

    # Utilities
    alejandra             # Another formatter (optional)
    jq                    # Parse JSON from nix commands
  ];

}

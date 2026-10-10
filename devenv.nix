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

  # === Git Hooks (Pre-commit Checks) ===
  git-hooks.hooks = {
    # Format Nix files before committing
    nixfmt.enable = true;

    # Remove dead Nix code
    deadnix.enable = true;

    # Lint Nix with statix
    statix.enable = true;

    # Optional: shellcheck for any shell scripts
    shellcheck.enable = true;
  };

  # === Common Maintenance Scripts ===
  scripts.check-config.exec = ''
    echo "Checking Nix expression validity..."
    nix flake check --print-build-logs ${config.devenv.root}
  '';

  scripts.format.exec = ''
    echo "Formatting all Nix files..."
    nixfmt-classic ${config.devenv.root}/**/*.nix
    deadnix --edit ${config.devenv.root}/**/*.nix
  '';

  scripts.test-home.exec = ''
    echo "Testing Home Manager configuration..."
    home-manager switch --flake ${config.devenv.root}#your-hostname
  '';

  # === Tasks (with ordering dependencies) ===
  tasks = {
    # Run checks before shell entry
    "pre:check".exec = ''
      nix fmt --dry-run
      deadnix --dry-run
    '';
    "devenv:enterShell".after = [ "pre:check" ];
  };

  # === Shell Entry ===
  enterShell = ''
    echo "🚀 NixOS/HM devenv shell loaded"
    echo "   Formatter:  nixfmt-classic"
    echo "   Linter:     statix"
    echo "   LSP:        nil / nixd"
    echo ""
    echo "   Common commands:"
    echo "   • devenv run check-config  # Validate flake"
    echo "   • devenv run format        # Format all Nix files"
    echo "   • devenv run test-home     # Apply HM config"
    echo "   • git commit               # Runs pre-commit hooks"
  '';

  # === Tests ===
  enterTest = ''
    echo "Testing Nix tooling..."
    nix --version
    home-manager --version
    nixfmt --version
    deadnix --version
    statix --version
  '';

  # === Container Support (Optional: For Local NixOS Testing) ===
  # If you want to test full NixOS builds in containers:
  # containers.nixos-test.image = pkgs.nixos;
  # containers.nixos-test.command = "nix-shell -p nix";
}

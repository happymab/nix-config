{ self, inputs, ... }: {

  # Home configuration flake using home-manager
  flake.homeModules.homeMab = { config, pkgs, ... }: {

    # Allow unfree packages (required for some multimedia codecs, NVIDIA drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    imports = [

      # ── Features configurations ─────────────────────────────
      self.homeModules.braveMab
    ];

    # Equivalent of hjem's user/directory options
    home.username = "mab";
    home.homeDirectory = "/home/mab";

    # Packages installed in the user's home profile
    home.packages = with pkgs; [

      # Proton
      proton-vpn
      proton-pass
      proton-authenticator
      protonmail-desktop

      # VSCode
      vscode

      # Development
      nixfmt

      # Utilities
      restic-browser

      # Miscellaneous
      cowsay
    ];

    # Equivalent of hjem's `files` — these end up as symlinks in $HOME
    home.file = {
      # Starship prompt configuration
      ".config/starship.toml".source = ./config/starship/starship.toml;

      # Zsh configuration - create an empty .zshrc to avoid the initialization message
      ".zshrc".text = "";

      # Global justfile
      ".config/just/justfile".source = ./config/just/justfile;

      # Git configuration
      ".gitconfig".text = ''
        [user]
          name = happymab
          email = happymab.dev@pm.me
        [init]
          defaultBranch = main
        [checkout]
          defaultRemote = origin
        [url "git@github.com:"]
          insteadOf = https://github.com/
      '';

      # ssh configuration
      ".ssh/config".text = ''
        Host github.com
          IdentityFile ~/.ssh/github_ed25519
          IdentitiesOnly yes
          AddKeysToAgent yes
      '';
    };

    # Equivalent of hjem's xdg.data.files
    xdg.dataFile = {
      # Copy wallpapers
      "wallpapers".source = ./assets/wallpapers;
    };

    # Required for home-manager to activate
    home.stateVersion = "26.05"; # match this to the HM/NixOS version you started with

  };
}
